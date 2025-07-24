//
//  CountdownAnimationView.swift
//  Beat100
//
//  Created by Seungah Ko on 7/22/25.
//

import SwiftUI

struct CountdownAnimationView: View {
    @State private var count: Int = 4
    @State private var timer: Timer?
    @State private var showCircle: Bool = false
    @State private var fillAmount: CGFloat = 0.0
    
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack{
                ZStack{
                    //Background Circle
                    CustomGradientCircle(progress: 100, width: 20)
                        .opacity(showCircle ? 0.2 : 0.0)
                        .frame(width: 220, height: 220)
                        .animation(.easeInOut(duration: 2.0), value: showCircle)
                        .opacity(showCircle ? 1.0 : 0.0)
                    
                    //Foreground Circle
                    CustomGradientCircle(progress: fillAmount, width: 20)
                        .frame(width: 220, height: 220)
                        .opacity(showCircle ? 1.0 : 0.0)
                        .animation(.easeInOut(duration: 1.0), value: fillAmount)
                        .animation(.easeInOut(duration: 1.0), value: showCircle)
                        .rotationEffect(.degrees(count == 4 ? 0 : 0))
                    
                    if count == 4 {
                        Text("준비")
                            .font(.nanumSquareNeo(type: .heavy, size: 50))
                            .foregroundStyle(.white)
                    } else {
                        Text(countText)
                            .font(.nanumSquareNeo(type: .heavy, size: 90))
                            .foregroundStyle(.white)
                    }
                }
                    .padding(.bottom, 28)
                    Text("CPR 측정")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                }
            }
            .onAppear {
                startCountdown()
            }
        }
    
    var countText: String {
        switch count {
        case 4: return "준비"
        case 3, 2, 1: return "\(count)"
        default: return ""
        }
    }
    
    func startCountdown() {
        count = 4
        fillAmount = 0.0
        showCircle = false

        // 준비 시: 0 → 1.0 채우기
        withAnimation(.easeInOut(duration: 1.0)) {
            fillAmount = 1.0
            showCircle = true
        }

        var step = 0

        // 1초 뒤부터 카운트다운
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
                if step <= 3 {
                    count = 3 - step
                    step += 1

                    // 진행 링 줄이기
                    withAnimation(.easeInOut(duration: 0.8)) {
                        switch count {
                        case 3: fillAmount = 0.66
                        case 2: fillAmount = 0.33
                        case 1: fillAmount = 0.0
                        default: break
                        }
                    }
                } else {
                    t.invalidate()
                    // 측정 중
                }
            }
        }
    }
}

#Preview {
    CountdownAnimationView()
}
