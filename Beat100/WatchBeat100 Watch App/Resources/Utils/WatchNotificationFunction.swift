//
//  WatchNotificationFunction.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/28/25.
//

import Foundation
import SwiftUI

class WatchNotificationFunction: ObservableObject {
    
    @Published var isGuideFinish: Bool = false
    @Published var isMeasuringComplete: Bool = false
    
    let ConnectivityManager = WatchConnectivityManager.shared

    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("GuideFinishNotification"), object: nil, queue: .main) { [weak self] _ in
            print("GuideFinish Notification received!")
            self?.isGuideFinish = true
        }
    }
    func MeasuringCompleteNotificationObservers(){
        NotificationCenter.default.addObserver(forName: Notification.Name("MeasuringCompleteNotification"), object: nil, queue: .main) { [weak self] _ in
            print("MeasuringComplete Notification received!")
            self?.isMeasuringComplete = true
        }
    }
}
