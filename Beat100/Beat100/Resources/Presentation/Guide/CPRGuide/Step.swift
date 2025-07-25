//
//  Step.swift
//  Beat100
//
//  Created by oliver on 7/25/25.
//


import SwiftUI

struct Step: View {
    var imageResource: ImageResource
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                Text(description)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .foregroundColor(.black)
            }
            .padding(10)
        }
    }
}

#Preview {
    Step(
        imageResource: .guide1,
        title: Constants.CPRGuideText.Step1.title,
        description: Constants.CPRGuideText.Step1.description
    )
}
