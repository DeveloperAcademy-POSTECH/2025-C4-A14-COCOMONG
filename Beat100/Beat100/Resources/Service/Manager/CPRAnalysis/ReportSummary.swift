//
//  ReportSummary.swift
//  Beat100
//
//  Created by 이현주 on 7/27/25.
//

import Foundation
import SwiftUI

// MARK: - 요약 레포트 분석 구조체
struct ReportSummary {
    static func countValidCPRSets(
        compressions: [DisplacementData],
        releases: [DisplacementData]
    ) -> (total: Int, count: Int, percentage: Double) {
        let total = min(compressions.count, releases.count)
        var validCount = 0
        var totalCompressionDepth: Double = 0.0
        var totalReleaseDepth: Double = 0.0
        
        for i in 0..<total {
            let compression = compressions[i]
            let release = releases[i]

            let compressionDepth = compression.displacement
            let releaseDepth = release.displacement
            let interval = abs(release.timestamp - compression.timestamp)

            let bpm = 30.0 / interval
            
            totalCompressionDepth += compressionDepth
            totalReleaseDepth += releaseDepth
            
            let isDepthValid = (4.0...6.0).contains(compressionDepth) && (4.0...6.0).contains(releaseDepth)
            let isBPMValid = (100.0...120.0).contains(bpm)
            print(bpm)
            print("압박 깊이: \(compressionDepth), 이완 깊이: \(releaseDepth), BPM: \(bpm)")

            if isDepthValid && isBPMValid {
                validCount += 1
            }
        }
        
        if total > 0 {
             let avgCompression = totalCompressionDepth / Double(total)
             let avgRelease = totalReleaseDepth / Double(total)
             print("평균 압박 깊이: \(avgCompression), 평균 이완 깊이: \(avgRelease)")
         } else {
             print("데이터 없음")
         }

        let percentage = (Double(validCount) / Double(total)) * 100.0
        return (total, validCount, percentage)
    }
}
