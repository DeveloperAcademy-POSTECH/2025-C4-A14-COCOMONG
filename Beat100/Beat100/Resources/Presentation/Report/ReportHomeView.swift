//
//  ReportHomeView.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct ReportHomeView: View {
    var body: some View {
        NavigationStack {
            VStack {
                ExplainPressureCardView()
            }
            .navigationTitle("리포트")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

#Preview {
    ReportHomeView()
}
