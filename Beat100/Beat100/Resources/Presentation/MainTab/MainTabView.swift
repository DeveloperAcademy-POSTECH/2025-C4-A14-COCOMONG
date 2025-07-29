//
//  MainTabView.swift
//  Beat100
//
//  Created by oliver on 7/24/25.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var notificationFunction: NotificationFunction
    
    var body: some View {
        TabView(selection: $notificationFunction.selectedTab) {
            VStack(spacing: 0) {
                GuideHomeView()
                Divider()
            }
            .tabItem {
                Label("가이드", systemImage: "book.fill")
            }
            .tag(0)

            VStack(spacing: 0) {
                ReportHomeView()
                    .tint(.black)
                Divider()
            }
            .tabItem {
                Label("리포트", systemImage: "heart.text.clipboard.fill")
            }
            .tag(1)
        }
        .tint(.beatDarkPink)
    }
}

#Preview {
    MainTabView()
}
