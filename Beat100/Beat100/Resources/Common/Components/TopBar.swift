//
//  TopBar.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct TopBar: View {
    var subtitle: String
    
    var body: some View {
        HStack(alignment: .center) {
            Title(subtitle: subtitle)
            Spacer()
            Image(.profile)
        }
        .padding(.horizontal, 4)
        .frame(width: 361, alignment: .center)
    }
}

private struct Title: View {
    let title = "BEAT100"
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.nanumSquareNeo(type: .heavy, size: 20))
                .foregroundColor(.black)
            
            Text(subtitle)
                .font(.nanumSquareNeo(type: .bold, size: 16))
                .foregroundColor(.black)
        }
    }
}

#Preview {
    TopBar(subtitle: "Apple Watch로 CPR 측정 시작하기")
}
