//
//  measureView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/22/25.
//

import SwiftUI
import CoreMotion
import UIKit

struct measureView: View {
    private let motionManager = CMMotionManager()
    @State private var compressionTimestamps: [TimeInterval] = []
    @State private var lastTriggerTime: TimeInterval = 0
    @State private var logs: [String] = []
    @State private var acceleration: CMAcceleration = .init(x: 0, y: 0, z: 0)
    @State private var isShaking: Bool = false
    @State private var currentRound: Int = 0
    @StateObject private var viewModel = HelpViewModel()
    let numbers = Array(1...5)
    @State private var allLogs: [[String]] = Array(repeating: [], count: 5)
    
    let manager = WatchConnectivityManager.shared
    
    var body: some View {
        Text("가속도 측정기")
        VStack{
            
            Picker("숫자 선택", selection: $viewModel.selectedIndex) {
                ForEach(numbers, id: \.self) { number in
                    Text("\(number)")
                        .font(.nanumSquareNeo(type: .heavy, size: 28))
                        .tag(number)
                }
            }
            HStack{
                Button(isShaking ? "멈추기" : "측정 시작") {
                    if isShaking {
                        motionManager.stopAccelerometerUpdates()
                    } else{
                        print("측정 시작")
                        startDetectingShakes()
                        
                    }
                    isShaking.toggle()
                }
                Button("전송"){
                    currentRound = 1
                    logs = []
                    startDetectingShakes()
                    viewModel.startTimer()
                }
                .onReceive(viewModel.$isCountdownDone) { value in
                    if value == true {
                        allLogs[currentRound-1] = logs
//                        sending()
                        motionManager.stopAccelerometerUpdates()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    viewModel.isCountdownDone = false
                        }
                        
                        if currentRound < viewModel.selectedIndex {
                            currentRound += 1
                            logs = []
                            startDetectingShakes()
                            viewModel.startTimer()
                        }
                        else{
                            for i in 0..<viewModel.selectedIndex{
                                sending(round: i)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func startDetectingShakes() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.accelerometerUpdateInterval = 0.05
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let acceleration = data?.acceleration else { return }
            
            self.acceleration = acceleration
            let now = ProcessInfo.processInfo.systemUptime
            
            let logEntry = String(format: "Z값: %.16f", acceleration.z)
            logs.append(logEntry)
            
            compressionTimestamps.append(now)
            lastTriggerTime = now
        }
    }
    
    func sending(round: Int) {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(allLogs[round]),
           let jsonString = String(data: data, encoding: .utf8) {
            manager.sendMessage(["allLogs": jsonString])
        } else {
            print("❌ Failed to encode zLogData")
        }
    }
}

#Preview {
    measureView()
}
