//
//  WatchBeat100App.swift
//  WatchBeat100 Watch App
//
//  Created by 이현주 on 7/15/25.
//

import SwiftUI

@main
struct WatchBeat100_Watch_AppApp: App {
    @StateObject var notificationFunction = WatchNotificationFunction()
    
    var body: some Scene {
        WindowGroup {
            RootFlowView()
                .onAppear {
                    notificationFunction.GuideHasSeenNotification()
                }
        }
    }
}
