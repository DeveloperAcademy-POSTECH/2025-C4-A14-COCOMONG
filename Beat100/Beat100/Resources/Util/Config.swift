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
