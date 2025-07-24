//
//  CountdownAnimationView.swift
//  Beat100
//
//  Created by Seungah Ko on 7/22/25.
//

import SwiftUI

struct CountdownAnimationView: View {
    @StateObject private var vm:CountdownViewModel
    
    init(vm: CountdownViewModel) {
            _vm = StateObject(wrappedValue: vm)
        }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack{
                ZStack{
                    //Background Circle
                    CustomGradientCircle(progress: 100, width: 20)
                        .opacity(vm.showCircle ? 0.2 : 0.0)
                        .frame(width: 220, height: 220)
                        .animation(.easeInOut(duration: 2.0), value: vm.showCircle)
                        .opacity(vm.showCircle ? 1.0 : 0.0)
                    
                    //Foreground Circle
                    CustomGradientCircle(progress: vm.fillAmount, width: 20)
                        .frame(width: 220, height: 220)
                    
                    Text(vm.countText)
                        .font(.nanumSquareNeo(type: .heavy, size: 90))
                        .foregroundStyle(.white)
                }
                    .padding(.bottom, 28)
                    Text("CPR 측정")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                }
            }
            .onAppear {
                vm.startCountdown()
            }
        }
    
}

#Preview {
    CountdownAnimationView(vm: CountdownViewModel())
}
