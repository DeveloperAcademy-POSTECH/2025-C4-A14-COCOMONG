//
//  WatchStartView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/21/25.
//

import SwiftUI

struct WatchStartView: View {
    @StateObject private var viewModel = ChooseCycleViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(edges: .all)
            VStack(spacing: 12){
                Text("iPhone과 Watch가 연동되었습니다. 정확한 CPR 측정을 위해 Apple Watch를 CPR 수행하는 아래쪽 손목에 착용했는지 확인하세요.")
                    .font(.system(size: 12, weight: .regular))
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
                
                Button(action: {
                    dismiss()
                }) {
                    Text("확인")
                        .font(.system(size: 14, weight: .regular))
                        .padding(.horizontal, 60) // 좌우 여백 줄임
                        .padding(.vertical, 12)    // 상하 여백 최소화
                        .background(Color.gray900)
                        .foregroundColor(.white)
                        .cornerRadius(100)
                        .fixedSize()
                }
                .buttonStyle(PlainButtonStyle())
            }
            
            .padding(.horizontal, 18)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("") {
                        dismiss()
                    }
                    .tint(Color.black)
                    .disabled(true)
                }
            }
        }
    }
}

#Preview {
    WatchStartView()
}
