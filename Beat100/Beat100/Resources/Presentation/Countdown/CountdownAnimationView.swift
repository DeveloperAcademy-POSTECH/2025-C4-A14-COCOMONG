//
//  CountdownAnimationView.swift
//  Beat100
//
//  Created by Seungah Ko on 7/22/25.
//

import SwiftUI

struct CountdownAnimationView: View {
    @StateObject var viewModel:CountdownViewModel
    var onComplete: () -> Void
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color.black.ignoresSafeArea(edges: .all)
                
#if os(iOS)
                VStack {
                    CountdownCircleView(progress: viewModel.fillAmount, showCircle: viewModel.showCircle, text: viewModel.countText, isWatchOS: false)
                        .padding(.bottom, 28)
                    Text("CPR 측정")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                }
#elseif os(watchOS)
                VStack {
                    CountdownCircleView(progress: viewModel.fillAmount, showCircle: viewModel.showCircle, text: viewModel.countText, isWatchOS: true)
                        .padding(.bottom, 14)
                    Text("CPR 측정")
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .bold))
                }
#endif
            }
            .disabledToolbar()
        }
        .onAppear {
            viewModel.onComplete = {
                onComplete()
            }
            viewModel.startCountdown()
        }
    }
    
}

#Preview {
    CountdownAnimationView(viewModel: CountdownViewModel(), onComplete: {})
}
