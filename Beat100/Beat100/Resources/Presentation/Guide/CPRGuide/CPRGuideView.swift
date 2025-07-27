//
//  CPRGuideView.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct CPRGuideView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomNavigationBar(title: {
                Text(Constants.CPRGuideText.navTitle)
            })
            Content()
        }
        .background(.gray200)
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
            .padding(.top, 40)
            .padding(.bottom, 102)
            .padding(.horizontal, 20)
        }
    }
}



#Preview {
    CPRGuideView()
}
