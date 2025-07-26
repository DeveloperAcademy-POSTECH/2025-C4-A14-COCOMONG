//
//  DetailSectionView.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import SwiftUI

@ViewBuilder
func DetailSectionView<Content: View>(title: String, @ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 16) {
        Text(title)
            .font(.nanumSquareNeo(type: .extrabold, size: 20))
            .foregroundStyle(Color.black)
            .padding(.leading, 10)
        
        content()
    }
}
