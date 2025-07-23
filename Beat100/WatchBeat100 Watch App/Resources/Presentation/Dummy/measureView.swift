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
    @State private var zLogData: [AccelerationData] = []
    @State private var acceleration: CMAcceleration = .init(x: 0, y: 0, z: 0)
    @State private var isShaking: Bool = false
    
    let manager = WatchConnectivityManager.shared
    
    struct AccelerationData: Codable {
        let timestamp: Double
        let user_acc_z: Double
    }
    
    var body: some View {
#if os(iOS)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(isShaking ? "멈추기" : "측정 시작") {
            if isShaking {
                motionManager.stopAccelerometerUpdates()
            } else{
                print("측정 시작")
                startDetectingShakes()
                
            }
            isShaking.toggle()
        }
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(logs.reversed(), id: \.self) { log in
                    Text(log)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
            }
        }
        .frame(width:300, height: 600)
        .background(Color.blue)
#elseif os(watchOS)
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        HStack{
            Button(isShaking ? "멈추기" : "측정 시작") {
                if isShaking {
                    motionManager.stopAccelerometerUpdates()
                    print(logs)
                } else{
                    print("측정 시작")
                    startDetectingShakes()
                    
                }
                isShaking.toggle()
            }
            Button("전송"){
                let encoder = JSONEncoder()
                    if let data = try? encoder.encode(zLogData),
                       let jsonString = String(data: data, encoding: .utf8) {
                        manager.sendMessage(["zLogData": jsonString])
                    } else {
                        print("❌ Failed to encode zLogData")
                    }
            }
        }
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(logs.reversed(), id: \.self) { log in
                    Text(log)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                }
            }
        }
        .frame(width:100, height: 100)
        .background(Color.blue)
#endif
    }
    
    private func startDetectingShakes() {
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.accelerometerUpdateInterval = 0.05
        motionManager.startAccelerometerUpdates(to: .main) { data, error in
            guard let acceleration = data?.acceleration else { return }
            
            self.acceleration = acceleration
            let now = ProcessInfo.processInfo.systemUptime
            zLogData.append(AccelerationData(timestamp: now, user_acc_z: acceleration.z))
            
            let jsonSample = AccelerationData(timestamp: now, user_acc_z: acceleration.z)
            if let jsonData = try? JSONEncoder().encode(jsonSample),
               let jsonString = String(data: jsonData, encoding: .utf8) {
                
            }
            let logEntry = String(format: "Z값: %.16f", acceleration.z)
            logs.append(logEntry)
            
            compressionTimestamps.append(now)
            lastTriggerTime = now
        }
    }
}

#Preview {
    measureView()
}
