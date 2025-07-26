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
    static let watchFontSize: CGFloat = 32
}
