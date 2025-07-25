//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

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
                    
                    NavigationLink {
                        WatchWearingGuideView(isPresented: $isPresented)
                    } label: {
                        Text("계속")
                            .largeButtonStyle()
                    }
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
    }
}

private struct Disclaimer: View {
    var body: some View {
        Text(Constants.AppMechanismGuideText.disclaimer)
        .font(.system(size: 12))
        .multilineTextAlignment(.center)
        .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
    }
}

#Preview {
    AppMechanismGuideView(isPresented: .constant(true))
}
