//
//  MeasuringFlowView.swift
//  Beat100
//
//  Created by 나현흠 on 7/25/25.
//

import SwiftUI

struct MeasuringFlowView: View {
    var selectedNumber: Int
    @Environment(\.dismiss) private var dismiss
    @State private var step: MeasuringStep = .countdown
    
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
            case .measuringComplete:
                MeasuringCompleteView {
                    step = .finish
                }
            case .finish:
                FinishView(selectedNumber: .constant(selectedNumber)) {
                    dismiss()
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MeasuringFlowView(selectedNumber: 1)
}
