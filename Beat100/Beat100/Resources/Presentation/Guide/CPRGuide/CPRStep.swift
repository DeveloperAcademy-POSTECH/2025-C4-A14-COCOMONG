//
//  Step.swift
//  Beat100
//
//  Created by oliver on 7/25/25.
//


import SwiftUI

struct CPRStep: View {
    var imageResource: ImageResource
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 15))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 15))
                    .lineSpacing(3)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
            }
            .padding(10)
        }
    }
}

#Preview {
    CPRStep(
        imageResource: .guide1,
        title: Constants.CPRGuideText.Step1.title,
        description: Constants.CPRGuideText.Step1.description
    )
}
