//
//  CountdownCircle.swift
//  Beat100
//
//  Created by 나현흠 on 7/27/25.
//

import SwiftUI

struct CountdownCircleView: View {
    let progress: CGFloat
    let showCircle: Bool
    let text: String
    let isWatchOS: Bool
    
    var body: some View {
        ZStack {
            CustomGradientCircle(progress: 100, width: isWatchOS ? CountdownConfig.watchCircleWidth : CountdownConfig.iosCircleWidth)
                .opacity(showCircle ? 0.2 : 0.0)
                .frame(width: isWatchOS ? CountdownConfig.watchCircleSize : CountdownConfig.iosCircleSize,
                       height: isWatchOS ? CountdownConfig.watchCircleSize : CountdownConfig.iosCircleSize)
                .opacity(showCircle ? 1.0 : 0.0)
            
            CustomGradientCircle(progress: progress, width: isWatchOS ? CountdownConfig.watchCircleWidth : CountdownConfig.iosCircleWidth)
                .frame(width: isWatchOS ? CountdownConfig.watchCircleSize : CountdownConfig.iosCircleSize,
                       height: isWatchOS ? CountdownConfig.watchCircleSize : CountdownConfig.iosCircleSize)
            
            Text(text)
                .font(.nanumSquareNeo(type: .heavy,
                                      size: isWatchOS ? CountdownConfig.watchFontSize : CountdownConfig.iosFontSize))
                .foregroundStyle(.white)
        }
    }
}
