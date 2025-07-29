//
//  RhythmAnalyzer.swift
//  Beat100
//
//  Created by 이현주 on 7/27/25.
//

import Foundation
import SwiftUI

// MARK: - bpm 분석 구조체
struct RhythmAnalyzer {
    static func detectPeaksBetweenValleys(
        signal: [Double],
        timestamps: [Double],
        valleyIndices: [Int]
    ) -> [Double] {
        guard valleyIndices.count >= 2 else { return [] }
        
        var peaks: [Double] = []
        
        for i in 0..<(valleyIndices.count - 1) {
            let start = valleyIndices[i]
            let end = valleyIndices[i + 1]
            
            guard end > start else { continue }
            
            let segment = signal[start...end]
            if let maxInSegment = segment.max(),
               let maxIndex = segment.firstIndex(of: maxInSegment) {
                let globalIndex = start + (maxIndex - segment.startIndex)
                peaks.append(timestamps[globalIndex])
            }
        }
        
        return peaks
    }
    
    static func detectValleyIndices(from signal: [Double], window: Int = 3, minDistance: Int = 5) -> [Int] {
        var valleys: [Int] = []
        var lastIndex = -minDistance
        
        for i in window..<(signal.count - window) {
            let current = signal[i]
            let isLocalMin = (1...window).allSatisfy { offset in
                current < signal[i - offset] && current < signal[i + offset]
            }
            let isFarEnough = i - lastIndex >= minDistance
            
            if isLocalMin && isFarEnough {
                valleys.append(i)
                lastIndex = i
            }
        }
        return valleys
    }

    static func calculateBPM(from peakTimestamps: [Double]) -> (bpm: Double, std: Double) {
        guard peakTimestamps.count >= 2 else { return (0, 0) }

        let intervals = zip(peakTimestamps, peakTimestamps.dropFirst()).map { $1 - $0 }
        let mean = intervals.reduce(0, +) / Double(intervals.count)
        let std = sqrt(intervals.map { pow($0 - mean, 2) }.reduce(0, +) / Double(intervals.count))

        let bpm = 60.0 / mean
        return (bpm, std)
    }
    
    /// 압박 사이 시간으로 실시간 BPM 계산
    static func calculateInstantaneousBPMs(from peaks: [Double]) -> [(time: Double, bpm: Double)] {
        guard peaks.count >= 2 else { return [] }

        var result: [(Double, Double)] = []

        for i in 1..<peaks.count {
            let interval = peaks[i] - peaks[i - 1]
            let bpm = 60.0 / interval
            let midpointTime = (peaks[i] + peaks[i - 1]) / 2
            result.append((time: midpointTime, bpm: bpm))
        }

        return result
    }
}
