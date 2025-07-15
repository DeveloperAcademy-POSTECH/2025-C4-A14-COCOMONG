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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
