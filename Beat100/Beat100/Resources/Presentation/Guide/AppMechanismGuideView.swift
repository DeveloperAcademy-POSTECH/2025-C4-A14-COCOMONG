//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct AppMechanismGuideView: View {
    @Binding var isPresented: Bool
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            CancelToolbar(isPresented: $isPresented)
            Content()
            Spacer()
            Disclaimer()
            LargeButton("다음") {
                navigationManager.navigate(to: .watchWearing)
            }
        }
        .padding(.top, 8)
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = "BEAT100 앱 작동 방식"
    let bodyText = """
        BEAT100은 Apple Watch의 모션 센서를 
        활용하여 CPR 중 손목의 움직임을 감지합니다. 
        압박 리듬, 속도, 깊이를 실시간으로 측정하여 
        올바른 압박을 유지할 수 있도록 돕습니다.
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

private struct Disclaimer: View {
    var body: some View {
        Text("""
        * BEAT100 앱은 교육 목적의 시뮬레이션 도구입니다.
        실제 위급 상황에서는 사용할 수 없습니다.
        """)
        .font(.system(size: 12))
        .multilineTextAlignment(.center)
        .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
        .padding(.bottom, 24)
    }
}

#Preview {
    AppMechanismGuideView(isPresented: .constant(true))
        .environment(NavigationManager())
}
