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
        Image("Profile")
            .resizable()
            .scaledToFit()
            .frame(width: 120)
    }
}
