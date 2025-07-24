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
        VStack{
            ZStack {
                Color.black.ignoresSafeArea(edges: .all)
                
#if os(iOS)
                VStack{
                    ZStack{
                        //Background Circle
                        CustomGradientCircle(progress: 100, width: 20)
                            .opacity(viewModel.showCircle ? 0.2 : 0.0)
                            .frame(width: 220, height: 220)
                            .animation(.easeInOut(duration: 2.0), value: viewModel.showCircle)
                            .opacity(viewModel.showCircle ? 1.0 : 0.0)
                        
                        //Foreground Circle
                        CustomGradientCircle(progress: viewModel.fillAmount, width: 20)
                            .frame(width: 220, height: 220)
                        
                        Text(viewModel.countText)
                            .font(.nanumSquareNeo(type: .heavy, size: 90))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 28)
                    Text("CPR 측정")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                }
#elseif os(watchOS)
                VStack{
                    ZStack{
                        //Background Circle
                        CustomGradientCircle(progress: 100, width: 12)
                            .opacity(viewModel.showCircle ? 0.2 : 0.0)
                            .frame(width: 126, height: 126)
                            .animation(.easeInOut(duration: 2.0), value: viewModel.showCircle)
                            .opacity(viewModel.showCircle ? 1.0 : 0.0)
                        
                        //Foreground Circle
                        CustomGradientCircle(progress: viewModel.fillAmount, width: 12)
                            .frame(width: 126, height: 126)
                        
                        Text(viewModel.countText)
                            .font(.nanumSquareNeo(type: .heavy, size: 32))
                            .foregroundStyle(.white)
                    }
                    .padding(.bottom, 14)
                    Text("CPR 측정")
                        .foregroundStyle(.white)
                        .font(.system(size: 12, weight: .bold))
                }
#endif
            }
        }
        .onAppear {
            viewModel.onComplete = {
                onComplete()
            }
            viewModel.startCountdown()
        }
        .toolbar {}
    }
    
}

#Preview {
    CountdownAnimationView(viewModel: CountdownViewModel(), onComplete: {})
}
