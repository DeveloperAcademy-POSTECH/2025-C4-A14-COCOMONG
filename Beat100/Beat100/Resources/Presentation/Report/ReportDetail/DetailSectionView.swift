//
//  DetailSectionView.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import SwiftUI

@ViewBuilder
func DetailSectionView<TopTrailing: View, Content: View>(title: String, @ViewBuilder trailingTopView: () -> TopTrailing, @ViewBuilder content: () -> Content) -> some View {
    VStack(alignment: .leading, spacing: 16) {
        HStack {
            Text(title)
                .font(.nanumSquareNeo(type: .extrabold, size: 20))
                .foregroundStyle(.black)
            
            Spacer()
            
            trailingTopView()
        }
        .padding(.leading, 10)
        
        content()
    }
}
