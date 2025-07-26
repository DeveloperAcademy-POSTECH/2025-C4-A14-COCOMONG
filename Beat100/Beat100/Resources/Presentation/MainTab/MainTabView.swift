//
//  MainTabView.swift
//  Beat100
//
//  Created by oliver on 7/24/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            Tab("가이드", systemImage: "book.fill") {
                VStack(spacing: 0) {
                    GuideHomeView()
                    Divider()
                }
            }
            
            Tab("리포트", systemImage: "heart.text.clipboard.fill") {
                VStack(spacing: 0) {
                    ReportHomeView()
                        .tint(.black)
                    Divider()
                }
            }
        }
        .tint(.beatDarkPink)
    }
}

#Preview {
    MainTabView()
}
