//
//  MeasurementStartView.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct MeasurementStartView: View {
    @Environment(NavigationManager.self) var navigationManager
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            BackToolbar()
            Content()
            Spacer()
            CompleteLargeButton("CPR 측정 시작하기") {
                isPresented = false
                
                //NOTE: sheet가 내려갈 때 보이지 않게 하기 위해 0.5초 뒤에 실행
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    navigationManager.popToRoot()
                }
            }
        }
        .padding(.top, 8)
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = "처음으로 CPR 측정하기"
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            //TODO: 실제 애니메이션으로 교체하기
            Rectangle()
                .frame(width: 393, height: 237)
            
            Text(titleText)
                .font(.nanumSquareNeo(type: .heavy, size: 28))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 3) {
                    Text("1.")
                        .frame(width: 24)
                    Text("“CPR 측정 시작하기\"").bold()
                    + Text("를 누르면 Apple Watch앱과 연동을 시작합니다.")
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("2.")
                        .frame(width: 24)
                    Text("Apple Watch 앱에서 **“확인” 버튼**을 누르면, iPhone과 Watch가 자동으로 연동돼 압박 리듬 가이드를 함께 제공합니다.")
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("3.")
                        .frame(width: 24)
                    Text("iPhone은 애니 근처 잘 보이는 곳에 두십시오.")
                }
            }
            .font(.system(size: 16))
            .foregroundColor(.black)
            .frame(maxWidth: 348, alignment: .topLeading)
        }
    }
}

#Preview {
    MeasurementStartView(isPresented: .constant(true))
        .environment(NavigationManager())
}
