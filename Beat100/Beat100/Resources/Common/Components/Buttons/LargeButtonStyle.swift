//
//  LargeButton.swift
//  Beat100
//
//  Created by oliver on 7/24/25.
//

import SwiftUI

struct LargeButtonStyle: ButtonStyle {
    let type: LargeButtonType
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 17, weight: .semibold))
            .foregroundColor(configuration.isPressed ? foregroundColor.opacity(0.25) : foregroundColor)
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

#Preview {
    Button("다음") {}
        .buttonStyle(LargeButtonStyle(type: .normal))
    Button("다음") {}
        .buttonStyle(LargeButtonStyle(type: .complete))
}
