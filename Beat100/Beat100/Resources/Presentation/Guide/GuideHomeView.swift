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
            Content(isPresented: $isPresented)
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
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            LargeCard(
                imageResource: .appleWatch,
                titleText: Constants.GuideCard.Measurement.title,
                contentText: Constants.GuideCard.Measurement.content,
                buttonText: Constants.GuideCard.Measurement.button,
                action: { isPresented = true },
                cardHeight: 186
            )
        }
        .frame(width: 361, alignment: .topLeading)
    }
}

#Preview {
    GuideHomeView()
}
