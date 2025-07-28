//
//  DisplacementData.swift
//  Beat100
//
//  Created by 이현주 on 7/27/25.
//

import Foundation

struct DisplacementData: Identifiable {
    let timestamp: TimeInterval
    let displacement: Double
    
    var id: TimeInterval { timestamp }
}

struct RhythmAnalysisResult {
    let relativeDepthData: [DisplacementData]
    let compressions: [DisplacementData]
    let releases: [DisplacementData]
    let bpmPoints: [DisplacementData]        // 분석용 인스턴탄이여 속도
    let relativeBPMData: [DisplacementData]  // 시간 보정된 bpm points
    let avgBPM: Double
    let stdDev: Double
    let total: Int
    let valid: Int
    let percent: Double

    static let empty = RhythmAnalysisResult(
        relativeDepthData: [], compressions: [], releases: [], bpmPoints: [], relativeBPMData: [],
        avgBPM: 0, stdDev: 0, total: 0, valid: 0, percent: 0
    )
}

