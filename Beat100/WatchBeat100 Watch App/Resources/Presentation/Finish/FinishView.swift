//
//  FinishView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/21/25.
//

import SwiftUI

struct FinishView: View {
    @Binding var selectedNumber: Int
    var onComplete: () -> Void
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.black
                    .edgesIgnoringSafeArea(.all)
                ScrollView{
                    VStack(spacing: 0){
                        Text("리포트 생성 완료")
                            .font(.nanumSquareNeo(type: .heavy, size: 16))
                            .padding(.bottom, 5)
                        
                        Text("\(selectedNumber)사이클")
                            .font(.nanumSquareNeo(type: .heavy, size: 12))
                            .padding(.bottom, 10)
                        
                        Image("Beat100_Check")
                            .frame(width:75, height: 75)
                            .padding(.horizontal, 46)
                            .padding(.bottom, 10)
                        
                        Text("iPhone의 BEAT100 앱에서")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        Text("CPR 피드백을 확인하세요.")
                            .font(.system(size: 14))
                            .multilineTextAlignment(.center)
                        
                        LargeActionButton(title: "완료") {
                            onComplete()
                        }
                        .padding(.top, 24)
                    }
                    .padding(.bottom, 12)
                    .disabledToolbar()
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    FinishView(selectedNumber: .constant(1), onComplete: {})
}
