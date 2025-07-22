//
//  WatchConnectView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/18/25.
//

import SwiftUI
import CoreMotion
import Combine

enum WatchViewState { case start, countdown, measurement }

struct WatchConnectView: View {
    @State private var viewState: WatchViewState = .start
    @State private var startTime: Date?
    @State private var countdownDone = false
    @State private var isGreen = false
    @State private var blinkTimer: Timer?
    @State var cancellables: Set<AnyCancellable> = []
    @StateObject private var viewModel = CountdownViewModel()

    var body: some View {
        ZStack {
            (isGreen ? Color.green : Color.black)
                .ignoresSafeArea()
                .animation(.easeInOut(duration: 0.1), value: isGreen)

            switch viewState {
            case .start:
                Button("Start") {
                    let sharedStart = Date().addingTimeInterval(3)
                    startTime = sharedStart
                    countdownDone = false
                    viewState = .countdown
                    WatchConnectivityManager.shared.sendStartTime(sharedStart)
                }
                .foregroundColor(.green)

            case .countdown:
                if let start = startTime {
                    CountdownView(viewModel: CountdownViewModel())
                }

            case .measurement:
                VStack {
                    Text("hi")
                }
            }
        }
        .onAppear {
            let manager = WatchConnectivityManager.shared
            manager.$isReady
                .receive(on: DispatchQueue.main)
                .sink { ready in
                    if ready { print("Watch session ready") }
                }
                .store(in: &cancellables)
        }
        .onChange(of: countdownDone) { done in
            if done {
                viewState = .measurement
                if let start = startTime {
                    startBlinking(from: start)
                }
            }
        }
    }

    func startBlinking(from startTime: Date) {
        let delay = startTime.timeIntervalSinceNow
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            blinkTimer = Timer.scheduledTimer(withTimeInterval: 60.0 / 110.0, repeats: true) { _ in
                isGreen.toggle()
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 20.0) {
                isGreen = false
                stopAll()
            }
        }
    }

    func stopAll() {
        blinkTimer?.invalidate()
        viewState = .start
    }
}
