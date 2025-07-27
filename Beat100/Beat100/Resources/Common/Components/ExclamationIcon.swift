//
//  ExclamationIcon.swift
//  Beat100
//
//  Created by oliver on 7/27/25.
//

import SwiftUI

struct ExclamationIcon: View {
    var body: some View {
        Text("!")
            .font(.system(size: 12, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 16, height: 16, alignment: .center)
            .background(.beatRed)
            .cornerRadius(11)
    }
}

#Preview {
    ExclamationIcon()
}
