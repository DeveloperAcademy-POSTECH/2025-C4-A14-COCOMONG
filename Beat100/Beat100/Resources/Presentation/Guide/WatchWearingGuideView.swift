//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct WatchWearingGuideView: View {
    @Binding var isPresented: Bool
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            BackCancelToolbar(isPresented: $isPresented)
            Content()
            Spacer()
            LargeButton("다음") {
                navigationManager.navigate(to: .compressionPosition)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = "Apple Watch 착용 가이드"
    
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
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 3) {
                    Text("1.")
                        .frame(width: 24)
                    Text("Apple Watch를 편한 손목의 손목뼈(요골) \n위쪽에 단단히 착용해주세요.")
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("2.")
                        .frame(width: 24)
                    Text("손목 센서와 피부가 밀착되어야 올바른 압박 \n속도·깊이·리듬을 정확하게 감지할 수 있습니다.")
                }
            }
            .font(.system(size: 16))
            .foregroundColor(.black)
            .frame(maxWidth: 348, alignment: .topLeading)
        }
        .frame(width: 361, alignment: .top)
    }
}

#Preview {
    WatchWearingGuideView(isPresented: .constant(true))
        .environment(NavigationManager())
}
