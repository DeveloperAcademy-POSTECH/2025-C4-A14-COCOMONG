//
//  CustomCircleProgressView.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct CustomCircleProgressView: View {
    let progress: Int
    
    var body: some View {
        ZStack {
            CustomGradientCircle(progress: 1.0)
                .opacity(0.2)
            
            CustomGradientCircle(progress: Double(progress) / 100)
            
            VStack(spacing: 4) {
                Text("\(progress)%")
                    .font(.nanumSquareNeo(type: .heavy, size: 12))
                
                Text("보통")
                    .font(.nanumSquareNeo(type: .bold, size: 12))
            }
            .foregroundStyle(Color.black)
        }
        .frame(width: 73)
    }
}

#Preview {
    CustomCircleProgressView(progress: 10)
}
