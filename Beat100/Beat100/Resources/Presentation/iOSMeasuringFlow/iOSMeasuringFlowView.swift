//
//  iOSMeasuringFlowView.swift
//  Beat100
//
//  Created by 나현흠 on 7/25/25.
//

import SwiftUI

struct iOSMeasuringFlowView: View {
    @EnvironmentObject var notificationFunction: NotificationFunction
    var selectedNumber: Int
    @Environment(\.dismiss) private var dismiss
    @State private var step: iOSMeasuringStep = .countdown
    
    var body: some View {
        ZStack {
            switch step {
            case .countdown:
                CountdownAnimationView(viewModel: CountdownViewModel()) {
                    step = .measuring
                }
            case .measuring:
                MeasuringView(selectedNumber: .constant(selectedNumber)) {
                    step = .measuringComplete
                }
                .onReceive(notificationFunction.$isMeasuringCancel) { isCancelled in
                    if isCancelled {
                        dismiss()
                    }
                }
            case .measuringComplete:
                MeasuringCompleteView(selectedNumber: .constant(selectedNumber)) {
                    dismiss()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    iOSMeasuringFlowView(selectedNumber: 1)
}
