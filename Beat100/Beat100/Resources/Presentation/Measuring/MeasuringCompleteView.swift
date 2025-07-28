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
    @StateObject private var notificationFunction = NotificationFunction()
    #elseif os(watchOS)
    @StateObject private var watchNotificationFunction = WatchNotificationFunction()
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
            }
            .padding(.top, config.topPadding)
            .disabledToolbar()
        }
#if os(iOS)
        .onReceive(NotificationCenter.default.publisher(for: .measuringComplete)) { _ in
            print("📬 Notification received directly!")
            onComplete()
        }
#elseif os(watchOS)
        .onAppear {
            watchNotificationFunction.MeasuringCompleteNotificationObservers()
        }
        .onChange (of: watchNotificationFunction.isMeasuringComplete) {
            if watchNotificationFunction.isMeasuringComplete {
                onComplete()
            }
        }
#endif
    }
}
