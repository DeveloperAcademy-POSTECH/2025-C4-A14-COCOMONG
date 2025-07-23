//
//  LargeCard.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct LargeCard: View {
    var titleText : String
    var contentText: String
    var buttonText: String
    var action: () -> Void
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(.appleWatch)
            
            VStack(alignment: .leading) {
                Title(titleText: titleText)
                Spacer()
                Content(contentText: contentText)
                Spacer()
                SmallButton(buttonText , action: action)
            }
            .frame(width: 249, alignment: .topLeading)
        }
        .padding(16)
        .frame(width: 361, height: 186, alignment: .topLeading)
        .background(.white)
        .cornerRadius(20)
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
    LargeCard(
        titleText: "Apple Watch에서 CPR 측정을 \n시작해보세요.",
        contentText: "Apple Watch로 손목의 움직임을 감지해 가슴 압박 깊이와 속도를 측정합니다. 이후 CPR 리포트를 제공합니다.",
        buttonText: "시작하기",
        action: {}
    )
}
