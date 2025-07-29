//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI
import RiveRuntime

struct CompressionPositionGuideView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            BackCancelToolbar(isPresented: $isPresented)
                .padding(.top, 8)
            VStack {
                Content()
                Spacer()
                NavigationLink("다음") {
                    RateAndDepthGuideView(isPresented: $isPresented)
                }
                .buttonStyle(LargeButtonStyle(type: .normal))
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
    let illustration: (fileName: String, width: CGFloat, height: CGFloat) = (fileName: "guide3", width: 1978, height: 1080)
    
    var body: some View {
        VStack(spacing: 22) {
            Text(titleText)
                .font(.nanumSquareNeo(type: .heavy, size: 28))
                .foregroundColor(.black)
            
            GeometryReader { geometry in
                RiveViewModel(fileName: illustration.fileName)
                    .view()
                    .frame(width: geometry.size.width)
            }
            .aspectRatio(illustration.width / illustration.height, contentMode: .fit)
            
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
