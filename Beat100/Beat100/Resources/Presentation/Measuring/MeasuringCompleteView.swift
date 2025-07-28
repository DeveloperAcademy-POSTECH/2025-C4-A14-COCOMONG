//
//  MeasuringCompleteView.swift
//  Beat100
//
//  Created by 나현흠 on 7/25/25.
//

import SwiftUI

struct MeasuringCompleteView: View {
    #if os(iOS)
    @Binding var selectedNumber: Int
    #endif
    
    var onComplete: () -> Void
    private let config = MeasuringCompleteConfig.current
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea(edges: .all)
            VStack {
                Text("측정완료")
                    .foregroundStyle(Color.white)
                    .font(.system(size: config.fontSize, weight: .heavy))
                
                BouncingDotsView(dotSize: config.dotSize)
                
                Text("리포트를 생성중입니다")
                    .foregroundStyle(Color.white)
                    .font(.system(size: config.fontSize, weight: .heavy))
                
                //TODO: 임시로 다음 동작 보기 위해서 넣어놨습니다. 측정완료 Notification 기능 업데이트 되면 제거하겠습니다.
                Button("종료"){
                    onComplete()
                }
            }
            .padding(.top, config.topPadding)
            .disabledToolbar()
        }
    }
}
