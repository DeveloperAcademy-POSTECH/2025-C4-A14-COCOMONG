//
//  LargeButton.swift
//  Beat100
//
//  Created by oliver on 7/24/25.
//

import SwiftUI



struct LargeButtonStyle: ViewModifier {
    let type: LargeButtonType
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(foregroundColor)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .frame(height: 56)
            .background(backgroundColor)
            .cornerRadius(14)
    }
    
    private var foregroundColor: Color {
        switch type {
        case .normal:
            return .black
        case .complete:
            return .white
        }
    }
    
    private var backgroundColor: Color {
        switch type {
        case .normal:
            return .beatMint
        case .complete:
            return .beatTeal
        }
    }
}

extension View {
    func largeButtonStyle(_ role: LargeButtonType = .normal) -> some View {
        modifier(LargeButtonStyle(type: role))
    }
}

#Preview {
    Button("다음") {}
        .largeButtonStyle()
    Button("다음") {}
        .largeButtonStyle(.complete)
}
