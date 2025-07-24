//
//  CountdownViewModel.swift
//  Beat100
//
//  Created by 나현흠 on 7/20/25.
//

import Foundation
import SwiftUI
import Combine

class CountdownViewModel: ObservableObject {
    @Published var showCircle: Bool = false
    @Published var fillAmount: CGFloat = 0.0
    @State private var timer: Timer?
    @Published private var count: Int = 4
    
    var countText: String {
        switch count {
        case 4: return "준비"
        case 3, 2, 1: return "\(count)"
        default: return ""
        }
    }
    
    func startCountdown() {

        // 준비 시: 0 → 1.0 채우기
        withAnimation(.easeInOut(duration: 1.0)) {
            fillAmount = 1.0
            showCircle = true
        }

        var step = 0

        // 1초 뒤부터 카운트다운
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { t in
                if step <= 3 {
                    self.count = 3 - step
                    step += 1

                    // 진행 링 줄이기
                    withAnimation(.easeInOut(duration: 0.8)) {
                        switch self.count {
                        case 3: self.fillAmount = 0.66
                        case 2: self.fillAmount = 0.33
                        case 1: self.fillAmount = 0.0
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
