//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct CompressionPositionGuideView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            BackCancelToolbar(isPresented: $isPresented)
                .padding(.top, 8)
            VStack {
                Content()
                Spacer()
                NavigationLink {
                    RateAndDepthGuideView(isPresented: $isPresented)
                } label: {
                    Text("다음")
                        .largeButtonStyle()
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = Constants.CompressionPositionGuideText.title
    let bodyText = Constants.CompressionPositionGuideText.body
    
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
                .fontWithLineHeight(font: .systemFont(ofSize: 16), lineHeight: 22)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
    }
}

#Preview {
    CompressionPositionGuideView(isPresented: .constant(true))
}
