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
            viewModel.startAnimating(bpm: MeasuringConfig.bpm)
            viewModel.selectedIndex = selectedNumber
            viewModel.startDetectingShakes()
            viewModel.startTimer()
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(selectedNumber) * 17) {
                onComplete()
            }
        }
        .onReceive(viewModel.$isCountdownDone) { value in
            if value == true {
                viewModel.handleCountdownComplete(onComplete: onComplete)
            }
        }
        .onDisappear {
            viewModel.stopAnimating()
        }
        .toolbar{
            ToolbarItem(placement: .cancellationAction) {
                Button("취소"){}
                    .tint(.gray900)
            }
        }
    }
#endif
}

#Preview {
    MeasuringView(selectedNumber: .constant(1), onComplete: {})
}
