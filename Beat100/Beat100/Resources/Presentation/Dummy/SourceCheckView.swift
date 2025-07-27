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
        Text("가속도 측정값 정리")
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(zLogData) { data in
                    Text("Z: \(data.user_acc_z), t: \(data.timestamp)")
                        .padding(.bottom, 4)
                }
            }
            .padding()
        }
        .onAppear {
            print("🟢 SourceCheckView onAppear called")

            NotificationCenter.default.addObserver(forName: Notification.Name("didReceiveAllLogs"), object: nil, queue: .main) { notification in
                print("📬 Notification received!")

                if let json = notification.userInfo?["allLogs"] as? String,
                   let data = json.data(using: .utf8),
                   let stringArray = try? JSONDecoder().decode([String].self, from: data) {
                    print("✅ Decoded [String] with \(stringArray.count) items")

                    let parsed = stringArray.enumerated().compactMap { index, value -> AccelerationData? in
                        let raw = value.replacingOccurrences(of: "Z값: ", with: "")
                        if let z = Double(raw) {
                            return AccelerationData(user_acc_z: z, timestamp: TimeInterval(index))
                        } else {
                            return nil
                        }
                    }

                    self.zLogData = parsed
                    print("✅ zLogData updated with \(parsed.count) items")
                    
                    // 🔍 분석 및 저장
                    Task {
                        let result = ReportAnalyzerService.analyze(from: parsed)
                        
                        do {
                            let context = PersistenceController.shared.container.viewContext
                            let report = try await ReportAnalyzerService.save(to: context, result: result)
                            print("✅ 저장 성공: \(report)")
                        } catch {
                            print("❌ 저장 실패: \(error)")
                        }
                    }
                } else {
                    print("❌ [String] 디코딩 실패")
                }
            }
        }
    }
}

#Preview {
    SourceCheckView()
}
