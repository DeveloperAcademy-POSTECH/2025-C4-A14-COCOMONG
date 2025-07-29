//
//  LargeCard.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct LargeCard: View {
    var imageResource: ImageResource
    var titleText : String
    var contentText: String
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(imageResource)
            
            VStack(alignment: .leading, spacing: 20) {
                Title(titleText: titleText)
                HStack {
                    Content(contentText: contentText)
                    Spacer()
                }
                
                HStack(alignment: .top, spacing: 12) {
                    SmallButton(buttonText , action: action)
                }
            }
        }
        .padding(20)
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
        
        LargeCard(
            imageResource: .cprHeart,
            titleText: Constants.GuideCard.CPR.title,
            contentText: Constants.GuideCard.CPR.content,
            buttonText: Constants.GuideCard.CPR.button,
            action: {}
        )
    }
}
