//
//  DepthEstimator.swift
//  Beat100
//
//  Created by 이현주 on 7/27/25.
//

import Foundation
import SwiftUI

// MARK: - 깊이 추정 구조체
struct DepthEstimator {
    let sampleRate: Double // Hz
    var dt: Double { 1.0 / sampleRate } // 시간 간격 dt를 계산

    func estimateDepth(from data: [AccelerationData]) -> [DisplacementData] {
        let gravity = 9.80665
        
        // 1. Z 가속도 (중력 단위로 보정)
        let accZRaw = data.map { $0.zValue * gravity }
        
        // 2. Baseline shift 제거 (가속도 기준선 평행이동)
        let accBaseline = FIRFilterMethod.estimateDynamicBaseline(from: accZRaw)
        let accZ = accZRaw.map { $0 - accBaseline }
        
        // 3. FIR 필터 적용 (1.5~2.5Hz 대역 통과)
        let coeff = FIRFilterMethod.makeBandpassFIRCoefficients(order: 48, sampleRate: sampleRate, lowCut: 1.5, highCut: 2.5)
        let filteredAcc = FIRFilterMethod.applyFIRFilter(signal: accZ, coefficients: coeff)
        
        // 4. 적분 (가속도 → 속도 → 변위)
        let velocity = FIRFilterMethod.integrate(signal: filteredAcc, dt: dt)
        let displacement = FIRFilterMethod.integrate(signal: velocity, dt: dt)
        
        // 5. Valley 추출 → 깊이 기반 동적 보정 비율 계산
        let valleyIndices = RhythmAnalyzer.detectValleyIndices(from: displacement)
        let scalingFactor = DepthEstimator.computeDynamicDepthScaling(displacement: displacement, valleyIndices: valleyIndices, targetDepthCm: 5.5)
        
        // 6. Baseline 제거 후 scalingFactor 적용 → cm 변환
        let displacementBaseline = FIRFilterMethod.estimateDynamicBaseline(from: displacement)
        let corrected = displacement.map { ($0 - displacementBaseline) * 650 * scalingFactor }
        
        return zip(data, corrected).map {
            DisplacementData(timestamp: $0.timestamp, displacement: $1)
        }
    }
    
    func estimateDynamicBaseline(from displacement: [Double], windowSize: Int = 100, flatnessThreshold: Double = 0.01) -> Double {
        guard displacement.count >= windowSize else {
            return displacement.reduce(0, +) / Double(displacement.count)
        }
        
        var bestBaseline = 0.0
        var lowestStd = Double.infinity
        
        for i in 0...(displacement.count - windowSize) {
            let window = Array(displacement[i..<(i + windowSize)])
            let mean = window.reduce(0, +) / Double(windowSize)
            let variance = window.map { pow($0 - mean, 2) }.reduce(0, +) / Double(windowSize)
            let std = sqrt(variance)
            
            if std < flatnessThreshold && std < lowestStd {
                bestBaseline = mean
                lowestStd = std
            }
        }
        
        return bestBaseline
    }
    
    static func computeDynamicDepthScaling(displacement: [Double], valleyIndices: [Int], targetDepthCm: Double = 5.5) -> Double {
        var depths: [Double] = []
        
        for i in 0..<(valleyIndices.count - 1) {
            let start = valleyIndices[i]
            let end = valleyIndices[i + 1]
            guard end > start else { continue }
            
            let segment = displacement[start...end]
            if let peak = segment.max(), let valley = segment.min() {
                depths.append(peak - valley)
            }
        }
        
        let avgDepth = depths.reduce(0, +) / Double(depths.count)
        guard avgDepth > 0 else { return 1.0 }
        
        // 목표 깊이에 도달하도록 스케일링 비율 반환
        return targetDepthCm / (avgDepth * 650) // 기존 650 계수 기준
    }
    
    /// 압박/이완 이벤트를 DisplacementData로 분리
    /// - Parameter extrema: (timestamp, displacement) 쌍의 리스트 (극값 기준)
    /// - Returns: 압박 리스트, 이완 리스트
    static func calculateInterpolatedCompressionAndReleaseDepths(
        peakTimes: [Double],
        valleyTimes: [Double],
        from depthData: [DisplacementData]
    ) -> (compressions: [DisplacementData], releases: [DisplacementData]) {
        var compressions: [DisplacementData] = []
        var releases: [DisplacementData] = []
        
        // 1. 피크와 밸리를 시간순으로 정렬
        let extrema: [(time: Double, isPeak: Bool)] =
        (peakTimes.map { ($0, true) } + valleyTimes.map { ($0, false) })
            .sorted { $0.time < $1.time }
        
        // 2. 고점 → 저점 → 고점 패턴 탐색
        for i in 0..<(extrema.count - 2) {
            let (t1, isP1) = extrema[i]
            let (t2, isP2) = extrema[i + 1]
            let (t3, isP3) = extrema[i + 2]
            
            if isP1 && !isP2 && isP3 {
                // 고점 → 저점 → 고점 패턴
                
                let peak1 = interpolatedDepth(at: t1, from: depthData)
                let valley = interpolatedDepth(at: t2, from: depthData)
                let peak2 = interpolatedDepth(at: t3, from: depthData)
                
                let compressionDepth = abs(peak1 - valley)
                let releaseDepth = abs(valley - peak2)
                
                let compressionTime = (t1 + t2) / 2
                let releaseTime = (t2 + t3) / 2
                
                compressions.append(.init(timestamp: compressionTime, displacement: compressionDepth))
                releases.append(.init(timestamp: releaseTime, displacement: releaseDepth))
            }
        }
        
        return (compressions, releases)
    }
    
    /// 간단한 선형 보간으로 피크 위치 근처 깊이를 추정
    static func interpolatedDepth(at time: Double, from data: [DisplacementData]) -> Double {
        guard let idx = data.firstIndex(where: { $0.timestamp >= time }) else {
            return 0
        }
        if idx == 0 { return data[0].displacement }

        let prev = data[idx - 1]
        let next = data[idx]
        let t = (time - prev.timestamp) / (next.timestamp - prev.timestamp)
        return prev.displacement + t * (next.displacement - prev.displacement)
    }
}
