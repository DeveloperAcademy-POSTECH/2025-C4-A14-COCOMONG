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
        .padding(.top, 8)
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = Constants.WatchWearingGuideText.title
    
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
                    Text(Constants.WatchWearingGuideText.step1)
                }
                
                HStack(alignment: .top, spacing: 3) {
                    Text("2.")
                        .frame(width: 24)
                    Text(Constants.WatchWearingGuideText.step2)
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
