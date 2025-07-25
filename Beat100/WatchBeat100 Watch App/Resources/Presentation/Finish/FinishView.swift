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
                VStack(spacing: 0){
                    Text("측정 완료")
                        .font(.system(size: 14, weight: .bold))
                    
                    Text("\(selectedNumber)사이클")
                        .font(.system(size: 10, weight: .bold))
                        .padding(.bottom, 10)
                    
                    Image("Beat100_Check")
                        .frame(width:75, height: 75)
                        .padding(.horizontal, 46)
                        .padding(.bottom, 10)
                    
                    Text("iPhone의 BEAT100 앱에서")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                    Text("CPR 피드백을 확인하세요.")
                        .font(.system(size: 12))
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.horizontal, 8.5)
                .toolbar{
                    ToolbarItem(placement: .topBarLeading) {
                        Button{
                            //TODO: 유저플로우 대로 Navigation 조정 예정
                        } label: {
                            Image(systemName: "xmark")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    FinishView(selectedNumber: .constant(1), onComplete: {})
}
