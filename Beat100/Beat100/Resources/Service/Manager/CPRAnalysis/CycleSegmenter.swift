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
//    static func splitCycles(
//        compressions: [DisplacementData],
//        releases: [DisplacementData],
//        setSize: Int = 30
//    ) -> [(compressions: [DisplacementData], releases: [DisplacementData])] {
//        let total = min(compressions.count, releases.count)
//        let limit = min((total / setSize), 30) // 최대 30사이클까지
//        var cycles: [(compressions: [DisplacementData], releases: [DisplacementData])] = []
//
//        for i in 0..<limit {
//            let startIndex = i * setSize
//            let endIndex = min(startIndex + setSize, total)
//
//            let cSlice = Array(compressions[startIndex..<endIndex])
//            let rSlice = Array(releases[startIndex..<endIndex])
//            cycles.append((compressions: cSlice, releases: rSlice))
//        }
//
//        return cycles
//    }
    /// 압박/이완 데이터를 주어진 세트 단위(기본: 30개)로 나눔
    static func splitCycles(
        compressions: [DisplacementData],
        releases: [DisplacementData],
        setSize: Int = 30,
        maxCycles: Int = 30
    ) -> [(compressions: [DisplacementData], releases: [DisplacementData])] {
        let total = min(compressions.count, releases.count)
        guard total >= setSize else { return [] }

        let numberOfCycles = min(total / setSize, maxCycles)
        var cycles: [(compressions: [DisplacementData], releases: [DisplacementData])] = []

        for i in 0..<numberOfCycles {
            let startIndex = i * setSize
            let endIndex = min(startIndex + setSize, total)

            // 각 세트 내의 압박/이완 슬라이스 생성
            let compSlice = Array(compressions[startIndex..<endIndex])
            let relSlice = Array(releases[startIndex..<endIndex])

            // 길이가 다르면 짝 맞춰줌
            let pairedCount = min(compSlice.count, relSlice.count)
            if pairedCount == 0 { continue }

            cycles.append((
                compressions: Array(compSlice.prefix(pairedCount)),
                releases: Array(relSlice.prefix(pairedCount))
            ))
        }

        return cycles
    }

    /// 각 사이클의 정확도를 계산하여 요약
    static func summarizeEachCycle(
        cycles: [(compressions: [DisplacementData], releases: [DisplacementData])]
    ) -> [(total: Int, count: Int, percentage: Double)] {
        return cycles.map {
            ReportSummary.countValidCPRSets(compressions: $0.compressions, releases: $0.releases)
        }
    }
}
