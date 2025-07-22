//
//  PracticeSyncView.swift
//  Beat100
//
//  Created by 나현흠 on 7/18/25.
//

import SwiftUI
import Combine

enum ViewPhase { case idle, countdown, measurement }

struct PracticeSyncView: View {
    @State private var phase: ViewPhase = .idle
    @State private var startTime: Date?
    @State private var countdownDone = false
    @State private var isGreen = false
    @State private var blinkTimer: Timer?
    @StateObject private var viewModel = CountdownViewModel()
    
    var body: some View {
        ZStack {
            (isGreen ? Color.green : Color.black)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.1), value: isGreen)
            
            switch phase {
            case .idle:
                Text("대기 중…")
                    .foregroundStyle(.white)
            case .countdown:
                if let start = startTime {
                    CountdownView(viewModel: CountdownViewModel())
                }
            case .measurement:
                Text("측정 중 (20초간 깜빡임)")
                    .foregroundStyle(.white)
            }
        }
        .onAppear {
            _ = WatchConnectivityManager.shared
            NotificationCenter.default.addObserver(
                forName: WatchConnectivityManager.startBlinkingNotification,
                object: nil,
                queue: .main
            ) { n in
                if let start = n.object as? Date {
                    startTime = start
                    countdownDone = false
                    phase = .countdown
                }
            }
        }
        .onChange(of: countdownDone) { oldvalue, done in
            if done {
                phase = .measurement
                startBlinking(duration: 20)
            }
        }
    }
    
    func startBlinking(duration seconds: Double) {
        blinkTimer = Timer.scheduledTimer(withTimeInterval: 60.0 / 110.0, repeats: true) { _ in
            isGreen.toggle()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            blinkTimer?.invalidate()
            blinkTimer = nil
            isGreen = false
            phase = .idle
        }
    }
}
