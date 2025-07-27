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

    func estimateDepth(from data: [AccelerationData]) -> [DisplacementData] { // 가속도 데이터를 입력으로 받아서 변위 데이터를 반환하는 메서드.
        let gravity = 9.80665
        let accZ = data.map { $0.user_acc_z * gravity }  // z축만 사용, 단위 m/s^2
//        let accZ = data.map { ($0.z * gravity) / cos($0.pitch) } //pitch 보정된 수직 z 가속도
//        let accZ = data.map {
//            let g = gravity
//            return sqrt(pow($0.x * g, 2) + pow($0.y * g, 2) + pow($0.z * g, 2))
//        } // x/y/z 합성 가속도로 시도해보기
        
        let coefficients = FIRFilterMethod.makeBandpassFIRCoefficients(order: 48, sampleRate: sampleRate, lowCut: 1.5, highCut: 2.5)
        let filteredAcc = FIRFilterMethod.applyFIRFilter(signal: accZ, coefficients: coefficients)
        
        let velocity = FIRFilterMethod.integrate(signal: filteredAcc, dt: dt)
        let displacement = FIRFilterMethod.integrate(signal: velocity, dt: dt)
        
        let baseline = FIRFilterMethod.estimateDynamicBaseline(from: displacement)
        let corrected = displacement.map { ($0 - baseline) * 650 } // 단위 cm
        // 최종 보정 (선형 회귀)
        //        let corrected = displacement.map { a * ($0 - baseline) + b }
        
        return zip(data, corrected).map {
            DisplacementData(timestamp: $0.0.timestamp, displacement: $0.1)
        }
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
