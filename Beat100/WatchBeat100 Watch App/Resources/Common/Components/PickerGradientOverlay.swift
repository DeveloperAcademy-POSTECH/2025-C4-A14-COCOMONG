//
//  PickerGradientOverlay.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/27/25.
//

import SwiftUI

struct PickerGradientOverlay: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 13)
            .stroke(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .beatPink, location: 0.0),
                        .init(color: .beatPink, location: 0.25),
                        .init(color: .beatBlue, location: 1.0)
                    ]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                ),
                lineWidth: 2
            )
            .frame(width:84, height:84)
    }
}

#Preview {
    PickerGradientOverlay()
}
