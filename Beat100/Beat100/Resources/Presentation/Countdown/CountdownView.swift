//
//  CountdownView.swift
//  Beat100
//
//  Created by 나현흠 on 7/18/25.
//

import SwiftUI

struct CountdownView: View {
    @StateObject var viewModel: CountdownViewModel
    
    var body: some View {
        VStack{
            ZStack{
                Color.black.ignoresSafeArea()
                
                //TODO: Circle은 그린이 Countdown circle 애니메이션 만들면 수정 할 예정 + Color.pink는 iOS Color Chip 추가 시 .beatPink로 수정
                Circle()
                    .fill(Color.pink)
                    .frame(width: 126, height: 126)
                    .padding(.horizontal, {
#if os(iOS)
                        82
#elseif os(watchOS)
                        20
#else
                        20
#endif
                    }())
                
                Text("\(viewModel.countdown)")
                    .font(.nanumSquareNeo(type: .heavy, size: 50))
                    .foregroundColor(.white)
                    .onAppear {
                        viewModel.startTimer()
                    }
            }
            Text("CPR 측정")
                .font(.system(size: 12, weight: .medium))
                
        }
        .frame(width: 167, height: 156)
    }
}

#Preview {
    CountdownView(viewModel: CountdownViewModel())
}
