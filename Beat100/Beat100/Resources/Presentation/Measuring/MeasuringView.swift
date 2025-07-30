import SwiftUI
import CoreMotion

struct MeasuringView: View {
    
    @StateObject private var viewModel = MeasuringViewModel()
    
#if os(iOS)
    @Binding var selectedNumber: Int
    var onComplete: () -> Void
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                (viewModel.beatAnimation ? Color.pink : Color.black)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: MeasuringConfig.bpm / 3), value: viewModel.beatAnimation)
                
                HeartBeatBackgroundView(geometry: geometry, beatAnimation: viewModel.beatAnimation)
                
                HeartIconView(beatAnimation: viewModel.beatAnimation)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            print("selectedNumber on iOS:", selectedNumber)
            viewModel.startAnimating(bpm: MeasuringConfig.bpm)
            viewModel.selectedIndex = selectedNumber
            viewModel.startIOSAnimationCycles(onComplete: onComplete)
        }
        .onDisappear {
            viewModel.stopAnimating()
        }
        .disabledToolbar()
    }
#elseif os(watchOS)
    @Binding var selectedNumber: Int
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var workoutManager: WorkoutManager
    var onComplete: () -> Void
    
    let ConnectivityManager = WatchConnectivityManager.shared
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                (viewModel.beatAnimation ? Color.pink : Color.black)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: MeasuringConfig.bpm / 3), value: viewModel.beatAnimation)
                
                HeartBeatBackgroundView(geometry: geometry, beatAnimation: viewModel.beatAnimation)
                
                HeartIconView(beatAnimation: viewModel.beatAnimation)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            workoutManager.startWorkout()
            viewModel.startAnimating(bpm: MeasuringConfig.bpm)
            viewModel.selectedIndex = selectedNumber
            viewModel.startDetectingShakes()
            viewModel.startTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(selectedNumber) * 19) {
                onComplete()
            }
        }
        .onReceive(viewModel.$isCountdownDone) { value in
            if value == true {
                viewModel.handleCountdownComplete(onComplete: onComplete)
            }
        }
        .onDisappear {
            workoutManager.stopWorkout()
            viewModel.stopAnimating()
        }
        .toolbar{
            ToolbarItem(placement: .cancellationAction) {
                Button {
                    ConnectivityManager.sendMessage([
                        "MeasuringCancelFlag": true,
                    ])
                    viewModel.reset()
                    dismiss()
                } label: {
                    Text("취소")
                        .padding(.horizontal, 3)
                }
                    .tint(.gray900)
            }
        }
    }
#endif
}
