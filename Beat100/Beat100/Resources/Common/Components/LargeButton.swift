//
//  c3.swift
//  Beat100
//
//  Created by 이현주 on 7/15/25.
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
        .frame(width: 361, height: 56, alignment: .top)
        .background(.beatMint)
        .cornerRadius(14)
    }
}

#Preview {
    LargeButton("다음", action: {})
}
