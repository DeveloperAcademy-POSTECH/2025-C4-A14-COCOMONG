//
//  LargeActionButton.swift
//  Beat100
//
//  Created by 나현흠 on 7/31/25.
//

import SwiftUI

struct LargeActionButton: View {
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.black)
        }
        .background(.beatBlue)
        .clipShape(RoundedRectangle(cornerRadius: 100))
    }
}
