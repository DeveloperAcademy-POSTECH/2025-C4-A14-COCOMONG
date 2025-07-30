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
    let sampleRate: Double
    var dt: Double { 1.0 / sampleRate }

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
    
    func estimateDynamicBaselineSmart(from displacement: [Double]) -> Double {
        let preSample = displacement.prefix(50)
        let range = (preSample.max() ?? 0) - (preSample.min() ?? 0)
        if range < 0.0015 {
            return preSample.reduce(0, +) / Double(preSample.count)
        }

        var bestBaseline = 0.0
        var lowestStd = Double.infinity
        let windowSize = 90

        for i in 0...(displacement.count - windowSize) {
            let window = Array(displacement[i..<(i + windowSize)])
            let mean = window.reduce(0, +) / Double(windowSize)
            let variance = window.map { pow($0 - mean, 2) }.reduce(0, +) / Double(windowSize)
            let std = sqrt(variance)

            if std < 0.01 && std < lowestStd {
                bestBaseline = mean
                lowestStd = std
            }
        }

        return bestBaseline
    }

    
    func estimateDynamicBaseline(from displacement: [Double], windowSize: Int = 90, flatnessThreshold: Double = 0.01) -> Double {
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


    // MARK: 압박 및 이완 구간 추출
    static func calculateInterpolatedCompressionAndReleaseDepths(
        peakTimes: [Double],
        valleyTimes: [Double],
        from depthData: [DisplacementData]
    ) -> (compressions: [DisplacementData], releases: [DisplacementData]) {
        var compressions: [DisplacementData] = []
        var releases: [DisplacementData] = []

        let extrema: [(time: Double, isPeak: Bool)] =
            (peakTimes.map { ($0, true) } + valleyTimes.map { ($0, false) })
            .sorted { $0.time < $1.time }

        for i in 0..<(extrema.count - 2) {
            let (t1, isP1) = extrema[i]
            let (t2, isP2) = extrema[i + 1]
            let (t3, isP3) = extrema[i + 2]

            if isP1 && !isP2 && isP3 {
                let peak1 = interpolatedDepth(at: t1, from: depthData)
                let valley = interpolatedDepth(at: t2, from: depthData)
                let peak2 = interpolatedDepth(at: t3, from: depthData)

                let compression = abs(peak1 - valley)
                let release = abs(valley - peak2)

                compressions.append(.init(timestamp: (t1 + t2) / 2, displacement: compression))
                releases.append(.init(timestamp: (t2 + t3) / 2, displacement: release))
            }
        }

        return (compressions, releases)
    }

    // MARK: 보조 함수
    static func interpolatedDepth(at time: Double, from data: [DisplacementData]) -> Double {
        guard let first = data.first, let last = data.last else { return 0.0 }
        if time <= first.timestamp { return first.displacement }
        if time >= last.timestamp { return last.displacement }

        for i in 0..<(data.count - 1) {
            let d1 = data[i]
            let d2 = data[i + 1]
            if d1.timestamp <= time && time <= d2.timestamp {
                let ratio = (time - d1.timestamp) / (d2.timestamp - d1.timestamp)
                return d1.displacement + ratio * (d2.displacement - d1.displacement)
            }
        }
        return 0.0
    }
}
