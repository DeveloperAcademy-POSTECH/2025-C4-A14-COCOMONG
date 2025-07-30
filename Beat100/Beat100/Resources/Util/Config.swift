//
//  Config.swift
//  Beat100
//
//  Created by 이현주 on 7/15/25.
//

import Foundation

struct MeasuringCompleteConfig {
    let dotSize: CGFloat
    let fontSize: CGFloat
    let topPadding: CGFloat
    
    static var current: MeasuringCompleteConfig {
        #if os(iOS)
        return MeasuringCompleteConfig(dotSize: 16, fontSize: 24, topPadding: 0)
        #elseif os(watchOS)
        return MeasuringCompleteConfig(dotSize: 10, fontSize: 12, topPadding: 20)
        #endif
    }
}

struct CountdownConfig {
    static let iosCircleSize: CGFloat = 220
    static let iosCircleWidth: CGFloat = 20
    static let iosFontSize: CGFloat = 90
    
    static let watchCircleSize: CGFloat = 126
    static let watchCircleWidth: CGFloat = 12
    static let watchFontSize: CGFloat = 55
}

struct MeasuringConfig {
    static let bpm: Double = 60.0 / 220.0
    static let startRadiusFactor: CGFloat = 0.1
    static let endRadiusFactor: CGFloat = 1.0
    static let smallCircleFactor: CGFloat = 0.15
    static let largeCircleFactor: CGFloat = 1.5
    static let blurSmall: CGFloat = 20
    static let blurLarge: CGFloat = 30
    static let heartScaleSmall: CGFloat = 0.25
    static let heartScaleLarge: CGFloat = 0.1
}

struct AccelerationData: Codable, Identifiable {
    var id: TimeInterval { timestamp }
    let zValue: Double
    let timestamp: Double
}
