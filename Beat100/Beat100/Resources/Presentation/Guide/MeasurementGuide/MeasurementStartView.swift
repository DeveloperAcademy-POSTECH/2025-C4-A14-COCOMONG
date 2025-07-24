//
//  MeasurementStartView.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct MeasurementStartView: View {
    @Environment(NavigationManager.self) var navigationManager
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            BackToolbar()
            Content()
            Spacer()
            CompleteLargeButton(Constants.MeasurementStartText.startButtonText) {
                isPresented = false
                
                //NOTE: sheet가 내려갈 때 보이지 않게 하기 위해 0.5초 뒤에 실행
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    navigationManager.popToRoot()
                }
            }
        }
        .padding(.top, 8)
        .navigationBarBackButtonHidden(true)
    }
}

private struct Content: View {
    let titleText = Constants.MeasurementStartText.title
    
    var body: some View {
        VStack(alignment: .center, spacing: 32) {
            //TODO: 실제 애니메이션으로 교체하기
            Rectangle()
                .frame(width: 393, height: 237)
            
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
            .frame(maxWidth: 348, alignment: .topLeading)
        }
    }
}

#Preview {
    MeasurementStartView(isPresented: .constant(true))
        .environment(NavigationManager())
}
