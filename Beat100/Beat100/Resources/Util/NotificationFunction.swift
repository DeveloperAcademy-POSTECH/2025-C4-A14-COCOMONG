//
//  NotificationFunction.swift
//  Beat100
//
//  Created by 나현흠 on 7/28/25.
//

import Foundation
import SwiftUI

class NotificationFunction: ObservableObject {
    
    @Published var showingMeasuringModal: Bool = false
    @Published var selectedNumber: Int = 0
    @Published var receivedLogs: [AccelerationData] = []

    func setupNotificationObservers() {
        NotificationCenter.default.addObserver(forName: Notification.Name("selectedNumberNotification"), object: nil, queue: .main) { [weak self] notification in
            if let selectedNum = notification.userInfo?["selectedNumber"] as? Int {
                self?.selectedNumber = selectedNum
                print("selectedNumber on iOS: \(selectedNum)")
            }
        }

        NotificationCenter.default.addObserver(forName: Notification.Name("MeasureStartNotification"), object: nil, queue: .main) { [weak self] _ in
            print("MeasureStart Notification received!")
            self?.showingMeasuringModal = true
        }

        NotificationCenter.default.addObserver(forName: Notification.Name("didReceiveAllLogs"), object: nil, queue: .main) { [weak self] notification in
            print("Notification received!")

            guard let self = self,
                  let json = notification.userInfo?["allLogs"] as? String,
                  let data = json.data(using: .utf8),
                  let parsed = try? JSONDecoder().decode([AccelerationData].self, from: data)
            else {
                print("디코딩 실패")
                return
            }

            self.receivedLogs = parsed
            print("\(parsed.count) items")

            Task {
                let result = ReportAnalyzerService.analyze(from: parsed)
                do {
                    let context = PersistenceController.shared.container.viewContext
                    let report = try await ReportAnalyzerService.save(to: context, result: result, cycleCount: self.selectedNumber)
                    print("저장 성공: \(report)")
                } catch {
                    print("저장 실패: \(error)")
                }
            }
        }
    }
}
