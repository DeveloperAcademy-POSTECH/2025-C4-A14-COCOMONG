//
//  SourceCheckView.swift
//  Beat100
//
//  Created by 나현흠 on 7/22/25.
//

import SwiftUI

struct AccelerationData: Codable, Identifiable {
    var id: TimeInterval { timestamp } // For List
    let user_acc_z: Double
    let timestamp: TimeInterval
}

struct SourceCheckView: View {
    @State private var zLogData: [AccelerationData] = []

    var body: some View {
        Text("hi")
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(zLogData) { data in
                    Text("Z: \(data.user_acc_z), t: \(data.timestamp)")
                        .padding(.bottom, 4)
                        .textSelection(.enabled)
                }
            }
            .padding()
        }
        .onAppear {
            NotificationCenter.default.addObserver(forName: Notification.Name("didReceiveZLogData"), object: nil, queue: .main) { notification in
                if let json = notification.userInfo?["json"] as? String,
                   let data = json.data(using: .utf8),
                   let decoded = try? JSONDecoder().decode([AccelerationData].self, from: data) {
                    self.zLogData = decoded
                }
            }
        }
    }
}

#Preview {
    SourceCheckView()
}
