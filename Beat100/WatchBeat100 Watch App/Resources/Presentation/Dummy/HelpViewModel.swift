//
//  HelpViewModel.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/23/25.
//

import Foundation

class HelpViewModel: ObservableObject {
    @Published var isCountdownDone: Bool = false
    @Published var selectedIndex: Int = 1
    var timer: Timer?
    
    func startTimer() {
        print("timer start check")
        isCountdownDone = false
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { [weak self] _ in
            print("timer end check")
            self?.isCountdownDone = true
        }
    }
}
