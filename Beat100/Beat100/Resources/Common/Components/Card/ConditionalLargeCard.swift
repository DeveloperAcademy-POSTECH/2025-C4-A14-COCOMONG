//
//  LargeCard.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct ConditionalLargeCard: View {
    var imageResource: ImageResource
    var titleText : String
    var contentText: String
    var buttonText: String
    var buttonEmphasizedText: String
    var action: () -> Void
    var isEmphasized: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 17) {
            Image(imageResource)
                .resizable()
                .scaledToFit()
                .frame(width: 64)
            
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 8) {
                    Title(titleText: titleText)
                    HStack {
                        Content(contentText: contentText)
                        Spacer()
                    }
                }
                
                HStack(alignment: .center, spacing: 7) {
                    SmallButton(isEmphasized ? buttonEmphasizedText : buttonText, action: action)
                    if isEmphasized {
                        ExclamationIcon()
                    }
                }
            }
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 20)
        .background(.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.2)
                .stroke(.gray400, lineWidth: 0.4)
        )
    }
}

private struct Title: View {
    var titleText: String
    
    var body: some View {
        Text(titleText)
            .font(.system(size: 16))
            .fontWeight(.bold)
            .foregroundColor(.black)
    }
}

private struct Content: View {
    var contentText: String
    
    var body: some View {
        Text(contentText)
            .fontWithLineHeight(font: .systemFont(ofSize: 15), lineHeight: 22)
            .foregroundColor(.black)
            .kerning(-0.23)
    }
}

#Preview {
    ZStack {
        Color.gray200
        
        VStack(spacing: 24) {
            ConditionalLargeCard(
                imageResource: .appleWatch,
                titleText: Constants.GuideCard.Measurement.title,
                contentText: Constants.GuideCard.Measurement.content,
                buttonText: Constants.GuideCard.Measurement.button,
                buttonEmphasizedText: Constants.GuideCard.Measurement.buttonEmphasized,
                action: {},
                isEmphasized: true
            )
            
            ConditionalLargeCard(
                imageResource: .appleWatch,
                titleText: Constants.GuideCard.Measurement.title,
                contentText: Constants.GuideCard.Measurement.content,
                buttonText: Constants.GuideCard.Measurement.button,
                buttonEmphasizedText: Constants.GuideCard.Measurement.buttonEmphasized,
                action: {},
                isEmphasized: false
            )
        }
    }
}
