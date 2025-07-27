//
//  HeartIconView.swift
//  Beat100
//
//  Created by 나현흠 on 7/27/25.
//

import SwiftUI

struct HeartIconView: View {
    let beatAnimation: Bool

    var body: some View {
        Image(systemName: "heart.fill")
            .resizable()
            .scaledToFit()
            .scaleEffect(beatAnimation ? MeasuringConfig.heartScaleLarge : MeasuringConfig.heartScaleSmall)
            .foregroundColor(beatAnimation ? .pink : .black)
            .shadow(color: .white.opacity(0.9), radius: 15)
            .animation(.spring(response: 0.4, dampingFraction: 0.5), value: beatAnimation)
    }
}
