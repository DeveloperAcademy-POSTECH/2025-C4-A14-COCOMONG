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
        ZStack{
            Color.black.ignoresSafeArea()
            
            Circle()
                .fill(Color.pink)
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
    }
}

#Preview {
    CountdownView(viewModel: CountdownViewModel())
}
