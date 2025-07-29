//
//  WatchNotificationFunction.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/28/25.
//

import Foundation
import SwiftUI

class WatchNotificationFunction: ObservableObject {
    @AppStorage("hasSeenGuide") var hasSeenGuide: Bool = false
    var isGuideFinish: Bool { hasSeenGuide }
    @Published var isMeasuringComplete: Bool = false

    let ConnectivityManager = WatchConnectivityManager.shared

    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("GuideFinishNotification"), object: nil, queue: .main) { [weak self] _ in
            print("GuideFinish Notification received!")
            self?.hasSeenGuide = true
        }
    }

    func MeasuringCompleteNotificationObservers(){
        NotificationCenter.default.addObserver(forName: Notification.Name("MeasuringCompleteNotification"), object: nil, queue: .main) { [weak self] _ in
            print("MeasuringComplete Notification received!")
            self?.isMeasuringComplete = true
        }
    }
    
    func GuideHasSeenNotification(){
        let hasSeenGuide = hasSeenGuide
        if !hasSeenGuide {
            setupNotificationObservers()
        }
    }
}
