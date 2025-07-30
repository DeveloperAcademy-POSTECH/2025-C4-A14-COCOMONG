//
//  HeartIconView.swift
//  Beat100
//
//  Created by 나현흠 on 7/27/25.
//

import SwiftUI

struct HeartIconView: View {
    @State private var fixedWidth: CGFloat?
    let beatAnimation: Bool

    var body: some View {
        GeometryReader { geometry in
            let width = fixedWidth ?? geometry.size.width * 0.25

            Image("Profile")
                .resizable()
                .scaledToFit()
                .frame(width: width)
                .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                .onAppear {
                    if fixedWidth == nil {
                        fixedWidth = geometry.size.width * 0.25
                    }
                }
        }
    }
}
