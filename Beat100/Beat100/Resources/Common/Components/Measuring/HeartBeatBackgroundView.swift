//
//  HeartBeatBackgroundView.swift
//  Beat100
//
//  Created by 나현흠 on 7/27/25.
//

import SwiftUI

struct HeartBeatBackgroundView: View {
    let geometry: GeometryProxy
    let beatAnimation: Bool

    var body: some View {
        Circle()
            .fill(
                RadialGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color(red: 0.11, green: 0.97, blue: 1), location: 0.2),
                        .init(color: Color(red: 0.98, green: 0.34, blue: 0.55), location: 0.45),
                    ]),
                    center: .center,
                    startRadius: 0,
                    endRadius: beatAnimation
                        ? geometry.size.width * MeasuringConfig.endRadiusFactor
                        : geometry.size.width * MeasuringConfig.startRadiusFactor
                )
            )
            .frame(
                width: beatAnimation
                    ? geometry.size.width * MeasuringConfig.largeCircleFactor
                    : geometry.size.width * MeasuringConfig.smallCircleFactor,
                height: beatAnimation
                    ? geometry.size.width * MeasuringConfig.largeCircleFactor
                    : geometry.size.width * MeasuringConfig.smallCircleFactor
            )
            .opacity(beatAnimation ? 1.0 : 0)
            .blur(radius: beatAnimation ? MeasuringConfig.blurLarge : MeasuringConfig.blurSmall)
            .animation(.easeInOut(duration: MeasuringConfig.bpm / 3), value: beatAnimation)
    }
}
