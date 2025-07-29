//
//  CycleSegmenter.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import Foundation
import SwiftUI

// MARK: - CycleSegmenter: 사이클 단위 분할과 요약 분석
struct CycleSegmenter {
    /// 압박/이완 데이터를 주어진 세트 단위(기본: 30개)로 나눔
    static func splitCycles(
        compressions: [DisplacementData],
        releases: [DisplacementData],
        setSize: Int = 30
    ) -> [(compressions: [DisplacementData], releases: [DisplacementData])] {
        let total = min(compressions.count, releases.count)
        var cycles: [(compressions: [DisplacementData], releases: [DisplacementData])] = []

        let fullCycleCount = total / setSize
        for i in 0..<fullCycleCount {
            let startIndex = i * setSize
            let endIndex = startIndex + setSize
            let cSlice = Array(compressions[startIndex..<endIndex])
            let rSlice = Array(releases[startIndex..<endIndex])
            cycles.append((compressions: cSlice, releases: rSlice))
        }

        // 마지막 남은 데이터를 하나의 사이클로 추가 (30개 미만)
        let remainingStartIndex = fullCycleCount * setSize
        if remainingStartIndex < total {
            let cSlice = Array(compressions[remainingStartIndex..<total])
            let rSlice = Array(releases[remainingStartIndex..<total])
            cycles.append((compressions: cSlice, releases: rSlice))
        }

        return cycles
    }
    
    /// 압박 시간 배열과 BPM 계산 결과를 받아 30개 압박에 30개 BPM을 매칭
    static func matchBPMsToCompressions(
        compressions: [DisplacementData],
        bpmSeries: [(time: Double, bpm: Double)]
    ) -> [(time: Double, bpm: Double)] {
        guard compressions.count >= 2 else { return [] }

        var result: [(time: Double, bpm: Double)] = []

        for i in 0..<compressions.count {
            if i < bpmSeries.count {
                // 압박 시간에 대응되는 bpm 시간 사용
                result.append((time: compressions[i].timestamp, bpm: bpmSeries[i].bpm))
            } else {
                // 부족할 경우 마지막 bpm 값 복제
                let lastBPM = bpmSeries.last?.bpm ?? 0.0
                result.append((time: compressions[i].timestamp, bpm: lastBPM))
            }
        }

        return result
    }
    
    static func sliceMatchedBPMPerCycle(
        matchedBPM: [(time: Double, bpm: Double)],
        compressions: [[DisplacementData]]
    ) -> [[(time: Double, bpm: Double)]] {
        return compressions.map { group in
            return group.map { compression in
                // 압박 타이밍과 가장 가까운 BPM
                let bestMatch = matchedBPM.min(by: { abs($0.time - compression.timestamp) < abs($1.time - compression.timestamp) })
                return (time: compression.timestamp, bpm: bestMatch?.bpm ?? 0.0)
            }
        }
    }
}
