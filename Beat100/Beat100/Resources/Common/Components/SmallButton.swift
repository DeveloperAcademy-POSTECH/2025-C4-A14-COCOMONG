//
//  SmallButton.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct SmallButton: View {
    let text: String
    let action: () -> Void
    
    init(_ text: String, action: @escaping () -> Void) {
        self.text = text
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.system(size: 15))
                .foregroundColor(.white)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(.beatDarkPink)
        .cornerRadius(40)
    }
}

#Preview {
    SmallButton("시작하기", action: {})
}
