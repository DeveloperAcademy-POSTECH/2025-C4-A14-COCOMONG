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
    var cardHeight: CGFloat
    
    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            Image(imageResource)
            
            VStack(alignment: .leading) {
                Title(titleText: titleText)
                Spacer()
                Content(contentText: contentText)
                Spacer()
                SmallButton(buttonText , action: action)
            }
            Spacer()
        }
        .padding(20)
        .background(.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .inset(by: 0.2)
                .stroke(.gray400, lineWidth: 0.4)
        )
        .frame(height: cardHeight)
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
            .font(.system(size: 15))
            .foregroundColor(.black)
    }
}

#Preview {
    ZStack {
        Color.gray200
        
        VStack(spacing: 24) {
            LargeCard(
                imageResource: .appleWatch,
                titleText: "Apple Watch에서 CPR 측정을 \n시작해보세요.",
                contentText: "Apple Watch로 손목의 움직임을 감지해 가슴 압박 깊이와 속도를 측정합니다. 이후 CPR 리포트를 제공합니다.",
                buttonText: "시작하기",
                action: {},
                cardHeight: 186
            )
            
            LargeCard(
                imageResource: .cprHeart,
                titleText: "CPR 전체 가이드라인",
                contentText: "119 신고부터 가슴 압박 방법까지, \nCPR 전체 수행 과정을 알아봅니다.",
                buttonText: "확인하기",
                action: {},
                cardHeight: 156
            )
        }
    }
}
