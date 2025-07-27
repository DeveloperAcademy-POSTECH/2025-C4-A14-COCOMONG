//
//  PickerGradientBackgroundColor.swift
//  Beat100
//
//  Created by 나현흠 on 7/27/25.
//

import SwiftUI

struct PickerGradientBackgroundColor: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(stops: [
                .init(color: .beatPink, location: 0.0),
                .init(color: .beatPink, location: 0.25),
                .init(color: .beatBlue, location: 1.0)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        ).opacity(0.25)
    }
}
