//
//  LargeButton.swift
//  Beat100
//
//  Created by oliver on 7/24/25.
//

import SwiftUI

struct LargeButton: View {
    let text: String
    let action: () -> Void

    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 56)
        .background(.beatMint)
        .cornerRadius(14)
        .padding(.horizontal, 16)
    }
}

struct CompleteLargeButton: View {
    let text: String
    let action: () -> Void

    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
        .frame(height: 56)
        .background(.beatTeal)
        .cornerRadius(14)
        .padding(.horizontal, 16)
    }
}

#Preview {
    LargeButton("다음", action: {})
    CompleteLargeButton("다음", action: {})
}

