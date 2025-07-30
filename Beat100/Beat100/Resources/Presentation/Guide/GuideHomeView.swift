//
//  SwiftUIView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct GuideHomeView: View {
    @State var isMeasurementGuidePresented: Bool = false
    @State var isCPRGuidePresented: Bool = false
    
    var body: some View {
        VStack(spacing: 6) {
            Title()
            Content(isMeasurementGuidePresented: $isMeasurementGuidePresented, isCPRGuidePresented: $isCPRGuidePresented)
            Spacer()
        }
        .background(.gray200)
        .sheet(isPresented: $isMeasurementGuidePresented) {
            NavigationStack {
                AppMechanismGuideView(isPresented: $isMeasurementGuidePresented)
            }
            .presentationDetents([.fraction(0.99)])
            .presentationCornerRadius(10)
        }
        .sheet(isPresented: $isCPRGuidePresented) {
            CPRGuideView()
                .presentationDragIndicator(.visible)
                .padding(.top, 10)
                .background(.gray200)
        }
    }
}

private struct Title: View {
    var body: some View {
        HStack {
            Image(.beat100Title)
                .resizable()
                .frame(width: 145, height: 30)
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .padding(.top, 44)
        .padding(.bottom, 20)
    }
}

private struct Content: View {
    @Binding var isMeasurementGuidePresented: Bool
    @Binding var isCPRGuidePresented: Bool
    @AppStorage("guideViewed") var guideViewed: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            ConditionalLargeCard(
                imageResource: .appleWatch,
                titleText: Constants.GuideCard.Measurement.title,
                contentText: Constants.GuideCard.Measurement.content,
                buttonText: Constants.GuideCard.Measurement.button,
                buttonEmphasizedText: Constants.GuideCard.Measurement.buttonEmphasized,
                action: { isMeasurementGuidePresented = true },
                isEmphasized: !guideViewed
            )
            LargeCard(
                imageResource: .cprHeart,
                titleText: Constants.GuideCard.CPR.title,
                contentText: Constants.GuideCard.CPR.content,
                buttonText: Constants.GuideCard.CPR.button,
                action: { isCPRGuidePresented = true }
            )
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    GuideHomeView()
}
