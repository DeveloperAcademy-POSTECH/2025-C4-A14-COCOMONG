//
//  CycleSummaryCellView.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import SwiftUI

struct CycleSummaryCellView: View {
    let cycleTitle: String
    let totalCount: Int
    let correctCount: Int
    let percent: Int
    
    var body: some View {
        HStack(spacing: 16) {
            Text(cycleTitle)
                .font(.system(size: 15, weight: .regular))
                .foregroundStyle(Color.black)
            
            Spacer()
            
            HStack {
                Text("\(correctCount)/\(totalCount)회")
                    .font(.nanumSquareNeo(type: .bold, size: 15))
                
                Spacer()
                
                Text("\(percent)%")
                    .font(.nanumSquareNeo(type: .heavy, size: 15))
            }
            .frame(width: 116)
            .foregroundStyle(percent < 80 ? Color.beatDarkPink : .black)
        }
    }
}

#Preview {
    CycleSummaryCellView(cycleTitle: "1 사이클", totalCount: 120, correctCount: 110, percent: 92)
}
