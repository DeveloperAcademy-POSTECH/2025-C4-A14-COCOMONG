//
//  Beat100App.swift
//  Beat100
//
//  Created by 이현주 on 7/15/25.
//

import SwiftUI

@main
struct Beat100App: App {
    let persistenceController = PersistenceController.shared
    init() {
        _ = WatchConnectivityManager.shared // ✅ 강제 초기화
    }
    
    var body: some Scene {
        WindowGroup {
            ReportHomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
