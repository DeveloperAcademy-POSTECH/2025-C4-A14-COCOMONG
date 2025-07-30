//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI
import RiveRuntime

struct AppMechanismGuideView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            CancelToolbar(isPresented: $isPresented)
                .padding(.top, 8)
            VStack {
                Content()
                Spacer()
                VStack(spacing: 24) {
                    Disclaimer()
                    
                    NavigationLink("계속") {
                        WatchWearingGuideView(isPresented: $isPresented)
                    }
                    .buttonStyle(LargeButtonStyle(type: .normal))
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = Constants.AppMechanismGuideText.title
    let bodyText = Constants.AppMechanismGuideText.body
    let illustration: (fileName: String, width: CGFloat, height: CGFloat) = (fileName: "guide1", width: 1978, height: 1080)
    
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
            
            Text(bodyText)
                .fontWithLineHeight(font: .systemFont(ofSize: 16), lineHeight: 22)
                .multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
    }
}

private struct Disclaimer: View {
    var body: some View {
        Text(Constants.AppMechanismGuideText.disclaimer)
            .fontWithLineHeight(font: .systemFont(ofSize: 12), lineHeight: 18)
            .multilineTextAlignment(.center)
            .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
    }
}

#Preview {
    AppMechanismGuideView(isPresented: .constant(true))
}
