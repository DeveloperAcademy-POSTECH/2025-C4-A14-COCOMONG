//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct RateAndDepthGuideView: View {
    @Binding var isPresented: Bool
    @Environment(NavigationManager.self) var navigationManager
    
    var body: some View {
        VStack {
            BackCancelToolbar(isPresented: $isPresented)
            Content()
            Spacer()
            LargeButton("다음") {
                navigationManager.navigate(to: .measurementStart)
            }
        }
    }
}

private struct Content: View {
    let titleText = "압박 속도와 깊이"
    
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
                    Text("가슴 압박 속도는 ")
                    + Text("분당 100-120회(bpm)").bold()
                    + Text("을\n권장합니다.")
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("2.")
                        .frame(width: 24)
                    Text("BEAT100은 **110bpm**에 맞춰 **Apple Watch 진동**으로 압박 리듬을 제공합니다.")
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("3.")
                        .frame(width: 24)
                    Text("깊이는 약 **5~6cm**를 유지하며 진동에 맞는 \n일정한 속도로 압박해주세요.")
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("4.")
                        .frame(width: 24)
                    Text("매 압박과 이완은 1:1이 되도록 해주세요. \n이완 시 가슴이 완전히 올라오도록 이완합니다.")
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
    RateAndDepthGuideView(isPresented: .constant(true))
        .environment(NavigationManager())
}
