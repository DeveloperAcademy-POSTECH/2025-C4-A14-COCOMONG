//
//  CustomGradientCircle.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct CustomGradientCircle: View {
    let progress: Double
    let width: CGFloat
    
    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color.beatPink.opacity(0.95), location: 0.27),
                        .init(color: Color.beatGradPink.opacity(0.98), location: 0.39),
                        .init(color: Color.beatBlue, location: 0.66)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                style: StrokeStyle(
                    lineWidth: width,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
    }
}

#Preview {
    CustomGradientCircle(progress: 0.2, width: 10)
}
