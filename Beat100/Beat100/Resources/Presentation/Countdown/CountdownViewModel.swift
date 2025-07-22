//
//  CountdownViewModel.swift
//  Beat100
//
//  Created by 나현흠 on 7/20/25.
//

import Foundation
import Combine

class CountdownViewModel: ObservableObject {
    @Published var countdown: Int = 3
    @Published var isCountdownDone: Bool = false
    private var cancellables: Set<AnyCancellable> = []
    
    func startTimer(){
        let timer = Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
        timer
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.countdown > 0 {
                    self.countdown -= 1
                }
                
                if self.countdown == 0 {
                    self.isCountdownDone = true
                }
            }
            .store(in: &cancellables)
    }
}
