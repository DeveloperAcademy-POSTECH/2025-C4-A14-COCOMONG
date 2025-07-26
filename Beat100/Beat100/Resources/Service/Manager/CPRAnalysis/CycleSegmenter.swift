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
        compressions: [AccelerationData],
        releases: [AccelerationData],
        setSize: Int = 30
    ) -> [(compressions: [AccelerationData], releases: [AccelerationData])] {
        let total = min(compressions.count, releases.count)
        let limit = min((total / setSize), 30) // 최대 30사이클까지
        var cycles: [(compressions: [AccelerationData], releases: [AccelerationData])] = []

        for i in 0..<limit {
            let startIndex = i * setSize
            let endIndex = min(startIndex + setSize, total)

            let cSlice = Array(compressions[startIndex..<endIndex])
            let rSlice = Array(releases[startIndex..<endIndex])
            cycles.append((compressions: cSlice, releases: rSlice))
        }

        return cycles
    }

    /// 각 사이클의 정확도를 계산하여 요약
    static func summarizeEachCycle(
        cycles: [(compressions: [AccelerationData], releases: [AccelerationData])]
    ) -> [(total: Int, count: Int, percentage: Double)] {
        return cycles.map {
            ReportSummary.countValidCPRSets(compressions: $0.compressions, releases: $0.releases)
        }
    }
}
