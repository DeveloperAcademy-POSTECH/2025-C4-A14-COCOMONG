//
//  BeforeWatchView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/20/25.
//

import SwiftUI

struct BeforeWatchView: View {
    let onNext: () -> Void
    
    var body: some View {
        VStack{
            ZStack{
                Image("iPhone_System")
                    .padding(.trailing, 20)
                Image("Beat100_WhiteLogo")
                    .padding(.leading, 35)
                    .padding(.top, 25)
            }
            .padding(.bottom, 16)
            Text("CPR 측정을 설정하려면\niPhone에서 Beat100앱을\n사용해주세요.")
                .font(.system(size: 11, weight: .regular))
                .multilineTextAlignment(.center)
        }
        .toolbar{}
    }
    
}

#Preview {
    BeforeWatchView(onNext: {})
}

