//
//  SwiftUIView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct GuideTapHomeView: View {
    @State private var navigationManager = NavigationManager()
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Button("Apple Watch에서 CPR 측정하기") {
                isPresented.toggle()
            }
            Text("CPR 전체 가이드라인")
        }
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
                        }
                    }
            }
        }
        
    }
}

#Preview {
    GuideTapHomeView()
}
