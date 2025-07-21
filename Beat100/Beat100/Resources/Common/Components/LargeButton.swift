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
    LargeButton(text: "다음", action: {})
}
