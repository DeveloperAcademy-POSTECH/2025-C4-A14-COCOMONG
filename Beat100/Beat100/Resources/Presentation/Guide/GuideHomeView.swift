//
//  SwiftUIView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct GuideHomeView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Title()
            Content(isPresented: $isPresented)
            Spacer()
        }
        .padding(.top, 44)
        .background(.gray200)
        .sheet(isPresented: $isPresented) {
            NavigationStack {
                AppMechanismGuideView(isPresented: $isPresented)
            }
            .presentationDetents([.fraction(0.99)])
            .presentationCornerRadius(10)
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
    @Binding var isPresented: Bool
    @AppStorage("guideViewed") var guideViewed: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            LargeCard(
                imageResource: .appleWatch,
                titleText: Constants.GuideCard.Measurement.title,
                contentText: Constants.GuideCard.Measurement.content,
                buttonText: Constants.GuideCard.Measurement.button,
                action: { isPresented = true },
                isEmphasized: !guideViewed
            )
            
            LargeCard(
                imageResource: .cprHeart,
                titleText: Constants.GuideCard.CPR.title,
                contentText: Constants.GuideCard.CPR.content,
                buttonText: Constants.GuideCard.CPR.button,
                action: {}
            )
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    GuideHomeView()
}
