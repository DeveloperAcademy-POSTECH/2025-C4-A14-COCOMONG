//
//  Beat100App.swift
//  Beat100
//
//  Created by 이현주 on 7/15/25.
//

import SwiftUI

@main
struct Beat100App: App {
    @StateObject var appState = AppState()
    @StateObject var notificationFunction = NotificationFunction()
    init() {
        _ = WatchConnectivityManager.shared
    }
    
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(appState)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .onAppear {
                    notificationFunction.setupNotificationObservers()
                }
                .fullScreenCover(isPresented: $notificationFunction.showingMeasuringModal) {
                    iOSMeasuringFlowView(selectedNumber: notificationFunction.selectedNumber)
                        .environmentObject(appState)
                }
        }
    }
}
