//
//  MeasurementStartView.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct MeasurementStartView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            BackToolbar()
                .padding(.top, 8)
            
            VStack(spacing: 32) {
                //TODO: 실제 애니메이션으로 교체하기
                Rectangle()
                    .frame(height: 237)
                
                VStack {
                    Content()
                    Spacer()
                    Button(Constants.MeasurementStartText.startButtonText) {
                        isPresented = false
                    }
                    .largeButtonStyle(.complete)
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
                .font(.nanumSquareNeo(type: .heavy, size: 28))
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
            }
            .font(.system(size: 16))
            .foregroundColor(.black)
            .padding(.horizontal, 9.5)
        }
    }
}

#Preview {
    MeasurementStartView(isPresented: .constant(true))
}
