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
        ScrollView(showsIndicators: false) {
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
        }
        .frame(width: 353, alignment: .topLeading)
    }
}

private struct Step: View {
    var imageResource: ImageResource
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 353, height: 210)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#Preview {
    CPRGuideView()
}
