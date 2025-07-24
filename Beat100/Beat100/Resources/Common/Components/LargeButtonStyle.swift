//
//  LargeButton.swift
//  Beat100
//
//  Created by oliver on 7/24/25.
//

import SwiftUI

struct LargeButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.black)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .frame(height: 56)
            .background(.beatMint)
            .cornerRadius(14)
            .padding(.horizontal, 16)
    }
}

struct CompleteLargeButtonStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(.white)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .frame(height: 56)
            .background(.beatTeal)
            .cornerRadius(14)
            .padding(.horizontal, 16)
    }
}

extension View {
    func largeButtonStyle() -> some View {
        modifier(LargeButtonStyle())
    }
    func completeLargeButtonStyle() -> some View {
        modifier(CompleteLargeButtonStyle())
    }
}

#Preview {
    Button("다음") {}
        .largeButtonStyle()
    Button("다음") {}
        .completeLargeButtonStyle()
}

