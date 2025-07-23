//
//  SwiftUIView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct GuideHomeView: View {
    @State private var navigationManager = NavigationManager()
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 30) {
            TopBar(subtitle: "Apple Watch로 CPR 측정 시작하기")
            
            Content() {
                isPresented.toggle()
            }
        }
        .padding(.top, 108)
        .frame(width: 393, height: 852, alignment: .top)
        .background(.gray200)
        .sheet(isPresented: $isPresented) {
            NavigationStack(path: $navigationManager.path) {
                AppMechanismGuideView(isPresented: $isPresented)
                    .environment(navigationManager)
                    .navigationDestination(for: MeasurementGuide.self) { value in
                        switch value {
                        case .appMechanism:
                            AppMechanismGuideView(isPresented: $isPresented)
                                .environment(navigationManager)
                        case .watchWearing:
                            WatchWearingGuideView(isPresented: $isPresented)
                                .environment(navigationManager)
                        case .compressionPosition:
                            CompressionPositionGuideView(isPresented: $isPresented)
                                .environment(navigationManager)
                        case .rateAndDepth:
                            RateAndDepthGuideView(isPresented: $isPresented)
                                .environment(navigationManager)
                        case .measurementStart:
                            MeasurementStartView(isPresented: $isPresented)
                                .environment(navigationManager)
                        }
                    }
            }
            .presentationDetents([.fraction(0.99)])
            .presentationCornerRadius(10)
        }
        
    }
}

private struct Content: View {
    var action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            LargeCard(
                titleText: "Apple Watch에서 CPR 측정을 \n시작해보세요.",
                contentText: "Apple Watch로 손목의 움직임을 감지해 가슴 압박 깊이와 속도를 측정합니다. 이후 CPR 리포트를 제공합니다.",
                buttonText: "시작하기",
                action: action
            )
        }
        .frame(width: 361, alignment: .topLeading)
    }
}

#Preview {
    GuideHomeView()
}
