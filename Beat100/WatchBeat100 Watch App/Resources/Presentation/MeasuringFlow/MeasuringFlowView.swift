//
//  MeasuringFlowView.swift
//  Beat100
//
//  Created by 나현흠 on 7/25/25.
//

import SwiftUI

struct MeasuringFlowView: View {
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
                MeasuringView {
                    step = .measuringComplete
                }
            case .measuringComplete:
                MeasuringCompleteView {
                    step = .finish
                }
            case .finish:
                FinishView(viewModel: ChooseCycleViewModel()) {
                    dismiss() // 전체 모달 닫기
                }
            }
        }
        .ignoresSafeArea() // fullscreenCover라면 안전영역 무시
    }
}

#Preview {
    MeasuringFlowView()
}
