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
        VStack {
            CancelToolbar(isPresented: $isPresented)
            Content()
            Spacer()
            Disclaimer()
            NavigationLink("계속") {
                WatchWearingGuideView(isPresented: $isPresented)
            }
            .largeButtonStyle()
        }
        .padding(.top, 8)
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
        .frame(width: 361, alignment: .top)
    }
}

private struct Disclaimer: View {
    var body: some View {
        Text(Constants.AppMechanismGuideText.disclaimer)
        .font(.system(size: 12))
        .multilineTextAlignment(.center)
        .foregroundColor(Color(red: 0.67, green: 0.67, blue: 0.67))
        .padding(.bottom, 24)
    }
}

#Preview {
    AppMechanismGuideView(isPresented: .constant(true))
}
