//
//  WatchConnectivityManager.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/18/25.
//

import Foundation
import WatchConnectivity

class WatchConnectivityManager: NSObject, WCSessionDelegate, ObservableObject {
    static let shared = WatchConnectivityManager()
    var session: WCSession?
    
    @Published var isReady = false

    private override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print("watchOS WCSession activated: \(activationState)")
        if activationState == .activated {
            DispatchQueue.main.async { self.isReady = true }
        }
    }

    func sendStartTime(_ startTime: Date) {
        let session = WCSession.default
        guard session.activationState == .activated && session.isReachable else {
            print("Watch session not ready (state: \(session.activationState), reachable: \(session.isReachable))")
            return
        }
        let message = ["startTime": startTime.timeIntervalSince1970]
        session.sendMessage(message, replyHandler: nil) { error in
            print("Watch send error: \(error.localizedDescription)")
        }
    }
    
    func sendMessage(_ message: [String: Any]) {
            let session = WCSession.default
            if session.isReachable {
                session.sendMessage(message, replyHandler: nil, errorHandler: { error in
                    print("sendMessage error: \(error.localizedDescription)")
                })
            } else {
                print("WCSession is not reachable.")
            }
        }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        print("iOS received message: \(message)")
        
        if let flag = message["GuideFinishFlag"] as? NSNumber, flag.boolValue {
            NotificationCenter.default.post(
                name: Notification.Name("GuideFinishNotification"),
                object: nil,
                userInfo: message
            )
        }
        
        if let flag = message["MeasuringCompleteFlag"] as? NSNumber, flag.boolValue {
            NotificationCenter.default.post(
                name: Notification.Name("MeasuringCompleteNotification"),
                object: nil,
                userInfo: message
            )
        }
    }
}
