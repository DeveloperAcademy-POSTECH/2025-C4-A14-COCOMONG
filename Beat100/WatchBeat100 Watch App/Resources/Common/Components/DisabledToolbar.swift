//
//  DisabledToolbar.swift
//  Beat100
//
//  Created by 나현흠 on 7/27/25.
//

import SwiftUI

struct DisabledToolbar: ViewModifier {
    func body(content: Content) -> some View {
        content.toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("") { }
                    .tint(Color.black)
                    .disabled(true)
            }
        }
    }
}

extension View {
    func disabledToolbar() -> some View {
        self.modifier(DisabledToolbar())
    }
}
