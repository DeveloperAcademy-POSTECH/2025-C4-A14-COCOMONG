//
//  BouncingDotsView.swift
//  Beat100
//
//  Created by 나현흠 on 7/26/25.
//

import Foundation
import SwiftUI

struct BouncingDotsView: View {
    var dotSize: CGFloat
    
    var body: some View {
        TimelineView(.animation) { timeline in
            let time = timeline.date.timeIntervalSinceReferenceDate
            HStack {
                ForEach(0..<3) { index in
                    Circle()
                        .frame(width: dotSize, height: dotSize)
                        .foregroundStyle(index == 0 ? .beatPink : index == 1 ? .beatGradPink : .beatBlue)
                        .offset(y: bounceOffset(for: index, time: time))
                        .padding(.trailing, index < 2 ? dotSize < 12 ? 10 : 15 : 0)
                }
            }
            .frame(height: dotSize < 12 ? 78 : 130)
        }
    }
    
    private func bounceOffset(for index: Int, time: TimeInterval) -> CGFloat {
        let delay = Double(index) * 0.2
        return sin((time + delay) * 5.5) * 8
    }
}

#Preview {
    BouncingDotsView(dotSize: 16)
}
