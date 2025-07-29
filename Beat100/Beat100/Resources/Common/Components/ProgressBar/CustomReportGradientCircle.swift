//
//  CustomReportGradientCircle.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import SwiftUI

struct CustomReportGradientCircle: View {
    let progress: Double
    
    var body: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                LinearGradient(
                    gradient: .init(colors: [Color.beatGradTeal, Color.beatTeal]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ),
                style: StrokeStyle(
                    lineWidth: 10,
                    lineCap: .round
                )
            )
            .rotationEffect(.degrees(-90))
    }
}

#Preview {
    CustomReportGradientCircle(progress: 10)
}
