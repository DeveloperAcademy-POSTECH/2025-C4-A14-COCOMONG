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
    
    var fillAmount: CGFloat {
        switch count {
        case 4: return 1.0
        case 3: return 0.66
        case 2: return 0.33
        case 1: return 0.0
        default: return 0.0
        }
    }
    
    var body: some View {
        
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack{
                ZStack{
                    //Background Circle
                    Circle()
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.blue,Color.green,Color.pink]),
                                startPoint: .topTrailing,
                                endPoint: .bottomLeading),
                            lineWidth: 20)
                        .opacity(0.2)
                        .frame(width: 230, height: 230)
                    
                    //Foreground Circle
                    Circle()
                        .trim(from: 0, to: fillAmount)
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.pink,Color.green,Color.blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing),
                            style: StrokeStyle (lineWidth: 20, lineCap: .round, lineJoin: .round)
                        )
                        .frame(width: 230, height: 230)
                        .rotationEffect(.degrees(-90))
                        .animation(.easeInOut(duration: 1.0), value: fillAmount)
                    
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
        var step = 0

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
            if step <= 4 {
                count = 4 - step
                step += 1
            } else {
                t.invalidate()
                // 다음 화면 전환 or 측정 진입
            }
        }
    }
}





#Preview {
    CountdownAnimationView()
}
