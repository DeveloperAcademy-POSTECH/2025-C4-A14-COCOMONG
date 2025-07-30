//
//  NotificationFunction.swift
//  Beat100
//
//  Created by 나현흠 on 7/28/25.
//

import Foundation
import SwiftUI
import HealthKit

class NotificationFunction: ObservableObject {
    
    @Published var selectedTab: Int = 0
    @Published var showingMeasuringModal: Bool = false
    @Published var isMeasuringComplete: Bool = false
    @Published var selectedNumber: Int = 0
    @Published var receivedLogs: [AccelerationData] = []
    @Published var isMeasuringCancel: Bool = false
    @Published var hasSavedReport: Bool = false
    
    let healthStore = HKHealthStore()
    let ConnectivityManager = WatchConnectivityManager.shared
    
    private var hasSetMeasuringCompleteObserver = false

    func observeSelectedNumber() {
        NotificationCenter.default.addObserver(forName: Notification.Name("selectedNumberNotification"), object: nil, queue: .main) { [weak self] notification in
            if let selectedNum = notification.userInfo?["selectedNumber"] as? Int {
                self?.selectedNumber = selectedNum
                print("selectedNumber on iOS: \(selectedNum)")
            }
        }
    }
    
    func observeMeasuringComplete(onComplete: @escaping () -> Void) {
        NotificationCenter.default.removeObserver(self, name: .measuringComplete, object: nil)
        NotificationCenter.default.addObserver(forName: .measuringComplete, object: nil, queue: .main) { [weak self] _ in
            guard let self = self else { return }
            if self.isMeasuringComplete { return }
            self.isMeasuringComplete = true
            print("onComplete 작동 확인")
            DispatchQueue.main.async {
                onComplete()
            }
        }
    }

    func observeMeasureStart() {
        NotificationCenter.default.addObserver(forName: Notification.Name("MeasureStartNotification"), object: nil, queue: .main) { [weak self] _ in
            print("MeasureStart Notification received!")
            self?.showingMeasuringModal = true
            self?.hasSavedReport = false
            self?.isMeasuringComplete = false
        }
    }
    
    func observeMeasuringCancel() {
        NotificationCenter.default.addObserver(forName: Notification.Name("MeasuringCancelNotification"), object: nil, queue: .main) { [weak self] _ in
            print("MeasuringCancel Notification received!")
            self?.isMeasuringCancel = true
        }
    }

    func observeDidReceiveAllLogs() {
        NotificationCenter.default.addObserver(forName: Notification.Name("didReceiveAllLogs"), object: nil, queue: .main) { [weak self] notification in
            guard let self = self, !self.hasSavedReport else {
                print("⚠️ 이미 저장됨 — 중복 저장 방지 또는 self is nil")
                return
            }
            
            print("Notification received!")

            guard !self.hasSavedReport,
                  let json = notification.userInfo?["allLogs"] as? String,
                  let data = json.data(using: .utf8),
                  let parsed = try? JSONDecoder().decode([AccelerationData].self, from: data)
            else {
                print("디코딩 실패")
                return
            }

            Task { @MainActor in
                let result = ReportAnalyzerService.analyze(from: parsed)
                do {
                    let context = PersistenceController.shared.container.viewContext
                    let report = try await ReportAnalyzerService.save(to: context, result: result, cycleCount: self.selectedNumber)
                    print("저장 성공: \(report)")
                    self.hasSavedReport = true
                    self.ConnectivityManager.sendMessage(["MeasuringCompleteFlag": true])
                    self.receivedLogs = parsed
                    print("지금 noti")
                    self.selectedTab = 1
                    print("실행 횟수수수퍼노바 체크")
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        print("1초에 실행 횟수 체크")
                        NotificationCenter.default.post(name: .measuringComplete, object: nil)
                    }
                } catch {
                    print("저장 실패: \(error)")
                }
            }
        }
    }
}
