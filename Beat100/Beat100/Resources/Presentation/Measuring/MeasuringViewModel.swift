//
//  MeasuringViewModel.swift
//  Beat100
//
//  Created by 나현흠 on 7/27/25.
//

import Foundation
import CoreMotion

class MeasuringViewModel: ObservableObject {
    let motionManager = CMMotionManager()
    private let manager = WatchConnectivityManager.shared
    
    struct LogEntry: Codable {
        let timestamp: TimeInterval
        let zValue: Double
    }

    @Published var logs: [LogEntry] = []
    
    @Published var beatAnimation = false
    @Published var isCountdownDone: Bool = false
    @Published var selectedIndex: Int = 1
    @Published private var acceleration: CMAcceleration = .init(x: 0, y: 0, z: 0)
    @Published private var compressionTimestamps: [TimeInterval] = []
    @Published private var lastTriggerTime: TimeInterval = 0
    @Published private var isShaking: Bool = false
    @Published var currentRound: Int = 0
    @Published var allLogs: [[LogEntry]] = Array(repeating: [], count: 5)
    
    private var beatTimer: Timer?
    private var roundTimer: Timer?
    
    func startTimer() {
        print("timer start check")
        isCountdownDone = false

        roundTimer?.invalidate()
        roundTimer = Timer.scheduledTimer(withTimeInterval: 17, repeats: false) { [weak self] _ in
            print("timer end check")
            self?.isCountdownDone = true
        }
    }

    func startAnimating(bpm: Double) {
        beatTimer?.invalidate()
        beatTimer = Timer.scheduledTimer(withTimeInterval: bpm, repeats: true) { [weak self] _ in
            self?.beatAnimation.toggle()
        }
    }

    func stopAnimating() {
        beatTimer?.invalidate()
        beatTimer = nil
    }
    
    func startDetectingShakes() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.accelerometerUpdateInterval = 0.05
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let acceleration = data?.acceleration else { return }
            
            self.acceleration = acceleration
            let now = Date().timeIntervalSince1970
            
            let entry = LogEntry(timestamp: now, zValue: acceleration.z)
            self.logs.append(entry)
            
            self.compressionTimestamps.append(now)
            self.lastTriggerTime = now
        }
    }
    
    func startIOSAnimationCycles(onComplete: @escaping () -> Void) {
        currentRound = 0
        func runCycle() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 17) {
                self.currentRound += 1
                if self.currentRound < self.selectedIndex {
                    runCycle()
                } else {
                    onComplete()
                }
            }
        }
        runCycle()
    }
    
    #if os (watchOS)
    
    func handleCountdownComplete(onComplete: @escaping () -> Void) {
        allLogs[currentRound] = logs
        motionManager.stopAccelerometerUpdates()
        
        if currentRound + 1 < selectedIndex {
            print("➡️ Moving to round \(currentRound + 1)")
            currentRound += 1
            logs = []
            startDetectingShakes()
            startTimer()
        } else {
            sending(round: 0)
            onComplete()
        }
    }
    
    func sending(round: Int) {
        let encoder = JSONEncoder()
        // Flatten all logs into a single array
        let combinedLogs = allLogs.flatMap { $0 }
        print(combinedLogs)
        if let data = try? encoder.encode(combinedLogs),
           let jsonString = String(data: data, encoding: .utf8) {
            WatchConnectivityManager.shared.sendMessage(["allLogs": jsonString])
        } else {
            print("Failed to encode combined allLogs")
        }
    }
    #endif
}
