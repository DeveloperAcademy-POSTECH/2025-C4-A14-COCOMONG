//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct CompressionPositionGuideView: View {
    @Binding var isPresented: Bool
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            BackCancelToolbar(isPresented: $isPresented)
            Content()
            Spacer()
            LargeButton("다음") {
                navigationManager.navigate(to: .rateAndDepth)
            }
        }
    }
}

private struct Content: View {
    let titleText = "가슴 압박 위치"
    let bodyText = """
        가슴 압박은 가슴뼈(흉골)의 아래쪽 1/2 지점,
        즉 양쪽 유두를 이은 선 중앙에 손바닥을 놓고
        실시합니다. 손바닥 뒤꿈치를 이용해 팔꿈치를
        곧게 편 상태로 수직으로 눌러주세요.
        """
    
    var body: some View {
        VStack(spacing: 22) {
            Text(titleText)
                .font(.nanumSquareNeo(type: .heavy, size: 28))
                .foregroundColor(.black)
            
            //TODO: 실제 애니메이션으로 교체하기
            Rectangle()
                .foregroundColor(.gray)
                .frame(height: 197)
                .cornerRadius(10)
            
            Text(bodyText)
            .font(.system(size: 16))
            .multilineTextAlignment(.center)
            .foregroundColor(.black)
        }
        .frame(width: 361, alignment: .top)
    }
}

#Preview {
    CompressionPositionGuideView(isPresented: .constant(true))
        .environment(NavigationManager())
}
