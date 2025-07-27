//
//  WatchConnectivityManager.swift
//  Beat100
//
//  Created by 나현흠 on 7/18/25.
//

import Foundation
import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityManager()
    static let startBlinkingNotification = Notification.Name("StartBlinking")
    static let didReceiveZLogData = Notification.Name("didReceiveZLogData")
    
    private override init() {
        super.init()
        print("WatchConnectivityManager initialized Complete")
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("iOS WCSession activated: \(activationState)")
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {}
    
    func sessionDidDeactivate(_ session: WCSession) {
        WCSession.default.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("iOS received message: \(message)")
        if let ts = message["startTime"] as? TimeInterval {
            NotificationCenter.default.post(name: Self.startBlinkingNotification, object: Date(timeIntervalSince1970: ts))
        }
        
        if let flag = message["MeasureStartFlag"] as? NSNumber, flag.boolValue {
            NotificationCenter.default.post(
                name: Notification.Name("MeasureStartNotification"),
                object: nil,
                userInfo: message
            )
        }
        
        if let selectedNum = message["selectedNumber"] as? Int {
            NotificationCenter.default.post(
                name: Notification.Name("selectedNumberNotification"),
                object: nil,
                userInfo: ["selectedNumber": selectedNum]
                )
        }
        
        if let jsonString = message["allLogs"] as? String {
            NotificationCenter.default.post(
                name: Notification.Name("didReceiveAllLogs"),
                object: nil,
                userInfo: ["allLogs": jsonString]
            )
        }
    }
}
