//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct WatchWearingGuideView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            BackCancelToolbar(isPresented: $isPresented)
            Content()
                .padding(.horizontal, 16)
            Spacer()
            NavigationLink {
                CompressionPositionGuideView(isPresented: $isPresented)
            } label: {
                Text("다음")
                    .largeButtonStyle()
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 40)
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
            .padding(.horizontal, 6.5)
            .font(.system(size: 16))
            .foregroundColor(.black)
        }
    }
}

#Preview {
    WatchWearingGuideView(isPresented: .constant(true))
}
