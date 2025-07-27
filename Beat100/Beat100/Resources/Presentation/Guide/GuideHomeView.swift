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
        VStack(spacing: 20) {
            Title()
            Content(isMeasurementGuidePresented: $isMeasurementGuidePresented, isCPRGuidePresented: $isCPRGuidePresented)
            Spacer()
        }
        .padding(.top, 44)
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
        }
    }
}

private struct Title: View {
    var body: some View {
        HStack {
            //TODO: 타이포 적용 후 교체
            Text("Title Here")
                .font(.system(size: 36, weight: .bold))
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}

private struct Content: View {
    @Binding var isMeasurementGuidePresented: Bool
    @Binding var isCPRGuidePresented: Bool
    @AppStorage("guideViewed") var guideViewed: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            LargeCard(
                imageResource: .appleWatch,
                titleText: Constants.GuideCard.Measurement.title,
                contentText: Constants.GuideCard.Measurement.content,
                buttonText: Constants.GuideCard.Measurement.button,
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
