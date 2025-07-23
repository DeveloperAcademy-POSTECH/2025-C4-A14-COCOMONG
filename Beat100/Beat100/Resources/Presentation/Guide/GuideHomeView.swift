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
        VStack {
            TopBar(subtitle: "Apple Watch로 CPR 측정 시작하기")
            
            Content()
            
//            Button("Apple Watch에서 CPR 측정하기") {
//                isPresented.toggle()
//            }
//            Text("CPR 전체 가이드라인")
        }
        .frame(width: 393, height: 852)
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
                        }
                    }
            }
            .presentationDetents([.fraction(0.99)])
            .presentationCornerRadius(10)
        }
        
    }
}

private struct Content: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack(alignment: .top, spacing: 16) {
                Image(.profile)
                
                VStack(alignment: .leading) {
                  // Space Between
                    Text("Apple Watch에서 CPR 측정하기")
                      .font(
                        Font.custom("SF Pro", size: 16)
                          .weight(.bold)
                      )
                      .foregroundColor(.black)
                      .frame(maxWidth: .infinity, alignment: .leading)
                  Spacer()
                  // Alternating Views and Spacers
                    Text("Apple Watch로 손목의 움직임을 감지해가슴 압박 깊이와 속도를 측정합니다.\n이후 CPR 리포트를 제공합니다.")
                      .font(Font.custom("SF Pro", size: 15))
                      .foregroundColor(.black)
                      .frame(maxWidth: .infinity, alignment: .top)
                }
                .padding(0)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
            .padding(16)
            .frame(maxWidth: .infinity, minHeight: 179, maxHeight: 179, alignment: .topLeading)
            .background(.white)
            .cornerRadius(20)
        }
        .frame(width: 361, alignment: .topLeading)
    }
}

#Preview {
    GuideHomeView()
}
