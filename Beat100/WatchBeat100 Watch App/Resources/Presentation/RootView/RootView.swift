//
//  RootView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/24/25.
//
import SwiftUI

struct RootView: View {
    @State private var currentStep: NavigationDestination = .watchStart

    var body: some View {
        ZStack {
            switch currentStep {
            case .watchStart:
                WatchStartView {
                    currentStep = .beforeWatch
                }

            case .beforeWatch:
                BeforeWatchView {
                    currentStep = .chooseCycle
                }

            case .chooseCycle:
                ChooseCycleView {
                    currentStep = .countdown
                }

            case .countdown:
                CountdownView(onNext: {
                    currentStep = .measuring
                }, viewModel: CountdownViewModel())

            case .measuring:
                MeasuringView {
                    currentStep = .finish
                }

            case .finish:
                FinishView(onNext: {
                    currentStep = .measuring
                }, viewModel: ChooseCycleViewModel())
            }
        }
    }
}
