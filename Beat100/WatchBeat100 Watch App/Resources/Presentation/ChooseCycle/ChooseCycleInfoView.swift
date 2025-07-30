//
//  ChooseCycleInfoView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/17/25.
//

import SwiftUI

struct ChooseCycleInfoView: View {
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            VStack{
                VStack{
                    HStack{
                        Text("CPR 사이클에 관해")
                            .font(.system(size: 15, weight: .bold))
                            .lineSpacing(4)
                        Spacer()
                    }
                    .padding(.bottom, 13)
                    .padding(.top, 24)
                    HStack{
                        VStack(alignment: .leading){
                            Text("1사이클은 가슴 압박 30회를")
                            Text("의미합니다.")
                            Text("교육 상황에 맞게 사이클 수를")
                            Text("설정하고, 제공되는 소리와 진동에")
                            Text("맞춰 정확한 속도를 유지하세요.")
                        }
                        .font(.system(size: 11, weight: .regular))
                        Spacer()
                    }
                }
                .padding(.bottom, 37)
                .padding(.leading, 10)
            }
        }
    }
}

#Preview {
    ChooseCycleInfoView()
}
