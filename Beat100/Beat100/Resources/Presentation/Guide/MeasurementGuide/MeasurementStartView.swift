//
//  MeasurementStartView.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI
import RiveRuntime

struct MeasurementStartView: View {
    @Binding var isPresented: Bool
    @AppStorage("guideViewed") var guideViewed: Bool = false
    let illustration: (fileName: String, width: CGFloat, height: CGFloat) = (fileName: "guide5", width: 393, height: 237)
    let ConnectivityManager = WatchConnectivityManager.shared
    
    var body: some View {
        VStack(spacing: 0) {
            BackToolbar()
                .padding(.top, 8)
            
            VStack(spacing: 32) {
                GeometryReader { geometry in
                    RiveViewModel(fileName: illustration.fileName)
                        .view()
                        .frame(width: geometry.size.width)
                }
                .aspectRatio(illustration.width / illustration.height, contentMode: .fit)
                
                VStack {
                    Content()
                    Spacer()
                    Button(Constants.MeasurementStartText.startButtonText) {
                        guideViewed = true
                        isPresented = false
                        ConnectivityManager.sendMessage([
                            "GuideFinishFlag": true,
                        ])
                    }
                    .buttonStyle(LargeButtonStyle(type: .complete))
                }
                .padding(.horizontal, 16)
            }
            .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = Constants.MeasurementStartText.title
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            Text(titleText)
                .font(.nanumSquareNeo(type: .extrabold, size: 28))
                .foregroundColor(.black)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(alignment: .top, spacing: 3) {
                    Text("1.")
                        .frame(width: 24)
                    Text(Constants.MeasurementStartText.step1)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("2.")
                        .frame(width: 24)
                    Text(Constants.MeasurementStartText.step2)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("3.")
                        .frame(width: 24)
                    Text(Constants.MeasurementStartText.step3)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("4.")
                        .frame(width: 24)
                    Text(Constants.MeasurementStartText.step4)
                }
            }
            .fontWithLineHeight(font: .systemFont(ofSize: 16), lineHeight: 22)
            .foregroundColor(.black)
            .padding(.horizontal, 9.5)
        }
    }
}

#Preview {
    MeasurementStartView(isPresented: .constant(true))
}
