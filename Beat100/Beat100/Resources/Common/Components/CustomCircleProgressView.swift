//
//  CustomCircleProgressView.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct CustomCircleProgressView: View {
    let progress: Double
    let percent: Int
    
    var body: some View {
        ZStack {
            CustomGradientCircle(progress: 1.0)
                .opacity(0.2)
            
            CustomGradientCircle(progress: progress)
            
            VStack(spacing: 4) {
                Text("\(percent)%")
                    .font(.nanumSquareNeo(type: .heavy, size: 12))
                
                Text("보통")
                    .font(.nanumSquareNeo(type: .bold, size: 12))
            }
            .foregroundStyle(Color.black)
        }
        .frame(width: 70)
    }
}

#Preview {
    CustomCircleProgressView(progress: 1, percent: 78)
}
