//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI
import RiveRuntime

struct RateAndDepthGuideView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            BackCancelToolbar(isPresented: $isPresented)
                .padding(.top, 8)
            VStack {
                Content()
                Spacer()
                NavigationLink("다음") {
                    MeasurementStartView(isPresented: $isPresented)
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
    let titleText = Constants.RateAndDepthGuideText.title
    let illustration: (fileName: String, width: CGFloat, height: CGFloat) = (fileName: "guide4", width: 1978, height: 1080)
    
    var body: some View {
        VStack(spacing: 22) {
            Text(titleText)
                .font(.nanumSquareNeo(type: .extrabold, size: 28))
                .foregroundColor(.black)
            
            GeometryReader { geometry in
                RiveViewModel(fileName: illustration.fileName)
                    .view()
                    .frame(width: geometry.size.width)
            }
            .aspectRatio(illustration.width / illustration.height, contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 3) {
                    Text("1.")
                        .frame(width: 24)
                    Text(Constants.RateAndDepthGuideText.step1)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("2.")
                        .frame(width: 24)
                    Text(Constants.RateAndDepthGuideText.step2)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("3.")
                        .frame(width: 24)
                    Text(Constants.RateAndDepthGuideText.step3)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("4.")
                        .frame(width: 24)
                    Text(Constants.RateAndDepthGuideText.step4)
                }
            }
            .padding(.horizontal, 6.5)
            .fontWithLineHeight(font: .systemFont(ofSize: 16), lineHeight: 22)
            .foregroundColor(.black)
        }
    }
}

#Preview {
    RateAndDepthGuideView(isPresented: .constant(true))
}
