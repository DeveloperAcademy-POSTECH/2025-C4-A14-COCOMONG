//
//  AppMechanismView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct RateAndDepthGuideView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            BackCancelToolbar(isPresented: $isPresented)
            Content()
                .padding(.horizontal, 16)
            Spacer()
            NavigationLink {
                MeasurementStartView(isPresented: $isPresented)
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
    let titleText = Constants.RateAndDepthGuideText.title
    
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
            .font(.system(size: 16))
            .foregroundColor(.black)
        }
    }
}

#Preview {
    RateAndDepthGuideView(isPresented: .constant(true))
}
