//
//  WatchStartView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/21/25.
//

import SwiftUI

struct WatchStartView: View {
    var body: some View {
        VStack(spacing: 12){
            Text("정확한 CPR 측정을 위해 iPhone과 안정적으로 연동되었는지, Apple Watch를 CPR 수행 시 편안한 쪽의 손목에 꼭 맞게 차고 있는지 확인하십시오. 현재 왼쪽 손목으로 설정되어 있습니다.")
                .font(.system(size: 12, weight: .regular))
                .multilineTextAlignment(.center)
                .lineLimit(7)
                .minimumScaleFactor(0.8)
            
            Button(action: {
                // TODO: asdf
            }) {
                Text("확인")
                    .font(.system(size: 14, weight: .regular))
                    .padding(.horizontal, 60) // 좌우 여백 줄임
                    .padding(.vertical, 12)    // 상하 여백 최소화
                    .background(Color.gray900)
                    .foregroundColor(.white)
                    .cornerRadius(100)
                    .fixedSize()
            }
            .buttonStyle(PlainButtonStyle())
        }
        
        .padding(.horizontal, 18)
        .toolbar{}
        
    }
}

#Preview {
    WatchStartView()
}
