//
//  ReportAnalyzerService.swift
//  Beat100
//
//  Created by 이현주 on 7/27/25.
//

import Foundation
import CoreData

struct ReportAnalyzerService {
    
    /// 분석 함수: rawData → RhythmAnalysisResult 생성
    static func analyze(from rawData: [AccelerationData]) -> RhythmAnalysisResult {
        let estimator = DepthEstimator(sampleRate: 25.0)
        let depthData = estimator.estimateDepth(from: rawData)
        guard !depthData.isEmpty else { return .empty }
        
        let startTime = depthData.first!.timestamp
        let relativeDepth = depthData.map {
            DisplacementData(timestamp: $0.timestamp - startTime, displacement: $0.displacement)
        }
        
        let displacements = depthData.map { $0.displacement }
        let timestamps = depthData.map { $0.timestamp }
        
        let valleyIndices = RhythmAnalyzer.detectValleyIndices(from: displacements)
        let peaks = RhythmAnalyzer.detectPeaksBetweenValleys(
            signal: displacements,
            timestamps: timestamps,
            valleyIndices: valleyIndices
        )
        let valleys = valleyIndices.map { timestamps[$0] }
        
        let relativePeaks = peaks.map { $0 - startTime }
        let relativeValleys = valleys.map { $0 - startTime }
        
        let (compressions, releases) = DepthEstimator.calculateInterpolatedCompressionAndReleaseDepths(
            peakTimes: relativePeaks,
            valleyTimes: relativeValleys,
            from: relativeDepth
        )
        
        let bpmInstant = RhythmAnalyzer.calculateInstantaneousBPMs(from: peaks)
        let relativeBPMData = bpmInstant.map {
            DisplacementData(timestamp: $0.time - startTime, displacement: $0.bpm)
        }
        
        let (avgBPM, stdDev) = RhythmAnalyzer.calculateBPM(from: peaks)
        let (total, valid, percent) = ReportSummary.countValidCPRSets(compressions: compressions, releases: releases)
        
        return RhythmAnalysisResult(
            relativeDepthData: relativeDepth,
            compressions: compressions,
            releases: releases,
            bpmPoints: bpmInstant.map { DisplacementData(timestamp: $0.time - startTime, displacement: $0.bpm) },
            relativeBPMData: relativeBPMData,
            avgBPM: avgBPM,
            stdDev: stdDev,
            total: total,
            valid: valid,
            percent: percent
        )
    }
    
    /// 저장 함수: analyze 결과를 Core Data로 저장
    @MainActor
    static func save(to context: NSManagedObjectContext, result: RhythmAnalysisResult, cycleCount: Int) async throws -> CprReport {
        let totalAccuracy = TotalAccuracy(
            context: context,
            correctNumber: Int16(result.valid),
            totalNumber: Int16(result.total)
        )
        
        let cyclePairs = CycleSegmenter.splitCycles(
            compressions: result.compressions,
            releases: result.releases
        )
        
        let limitedCycles = Array(cyclePairs.prefix(cycleCount))
        let cycles: [CprCycle] = limitedCycles.enumerated().map { offset, pair in
            let summary = ReportSummary.countValidCPRSets(
                compressions: pair.compressions, releases: pair.releases
            )
            let accuracy = CycleAccuracy(
                context: context,
                correctNumber: Int16(summary.count),
                totalNumber: Int16(summary.total)
            )
            
            let bpmPoints = NSSet(array: pair.compressions.enumerated().compactMap { idx, point in
                guard result.bpmPoints.indices.contains(idx) else { return nil }
                return BpmPoint(
                    context: context,
                    time: point.timestamp,
                    bpm: result.bpmPoints[idx].displacement
                )
            })
            
//            let depthPoints = NSSet(array: pair.compressions.enumerated().map { idx, point in
//                DepthPoint(
//                    context: context,
//                    compressionNumber: Double(idx + 1),
//                    depth: point.displacement
//                )
//            })
            
            let depthPoints = NSSet(array:
                pair.compressions.enumerated().flatMap { idx, compression in
                    guard pair.releases.indices.contains(idx) else { return [] }
                    let release = pair.releases[idx]
                    return [
                        DepthPoint(
                            context: context,
                            compressionNumber: Double(idx * 2 + 1), // 압박: 홀수
                            depth: compression.displacement
                        ),
                        DepthPoint(
                            context: context,
                            compressionNumber: Double(idx * 2 + 2), // 이완: 짝수
                            depth: release.displacement
                        )
                    ]
                }
            )
            
            return CprCycle(
                context: context,
                accuracy: accuracy,
                bpmPoints: bpmPoints,
                depthPoints: depthPoints
            )
        }
        
        return try await CprReport.create(
            context: context,
            totalAccuracy: totalAccuracy,
            numberOfCycles: Int16(cycleCount),
            cycles: cycles
        )
    }
}
