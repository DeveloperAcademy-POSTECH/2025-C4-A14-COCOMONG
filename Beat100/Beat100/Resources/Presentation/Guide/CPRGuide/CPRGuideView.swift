//
//  CPRGuideView.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct CPRGuideView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            TopBar()
            Content()
        }
        .background(.gray200)
    }
}

private struct TopBar: View {
    var body: some View {
        HStack {
            Spacer()
            Text(Constants.CPRGuideText.topBarTitle)
                .font(.system(size: 16, weight: .bold))
            Spacer()
        }
        .padding(.vertical, 11)
        .padding(.horizontal, 16)
    }
}

private struct Content: View {
    var body: some View {
        ScrollView() {
            VStack(alignment: .leading, spacing: 24) {
                Step(
                    imageResource: .guide1,
                    title: Constants.CPRGuideText.Step1.title,
                    description: Constants.CPRGuideText.Step1.description
                )
                Step(
                    imageResource: .guide2,
                    title: Constants.CPRGuideText.Step2.title,
                    description: Constants.CPRGuideText.Step2.description
                )
                Step(
                    imageResource: .guide3,
                    title: Constants.CPRGuideText.Step3.title,
                    description: Constants.CPRGuideText.Step3.description
                )
                Step(
                    imageResource: .guide4,
                    title: Constants.CPRGuideText.Step4.title,
                    description: Constants.CPRGuideText.Step4.description
                )
                Step(
                    imageResource: .guide5,
                    title: Constants.CPRGuideText.Step5.title,
                    description: Constants.CPRGuideText.Step5.description
                )
            }
            .padding(.leading, 20)
            .padding(.trailing, 18)
            .padding(.bottom, 69)
        }
        .padding(.trailing, 2)
    }
}

#Preview {
    CPRGuideView()
}
