//
//  MeasuringCompleteView.swift
//  Beat100
//
//  Created by 나현흠 on 7/25/25.
//

import SwiftUI

struct MeasuringCompleteView: View {
    var onComplete: () -> Void
    
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea(edges: .all)
#if os(iOS)
            VStack{
                Text("측정완료")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, weight: .heavy))
                HStack{
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.beatPink)
                        .padding(.trailing, 15)
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.beatGradPink)
                        .padding(.trailing, 15)
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(.beatBlue)
                }
                .frame(height: 130)
                Text("리포트를 생성중입니다")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 24, weight: .heavy))
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("") {
                    }
                    .tint(Color.black)
                    .disabled(true)
                }
            }
#elseif os(watchOS)
            VStack{
                Text("측정완료")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12, weight: .heavy))
                HStack{
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.beatPink)
                        .padding(.trailing, 10)
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.beatGradPink)
                        .padding(.trailing, 10)
                    Circle()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.beatBlue)
                }
                .frame(height: 78)
                Text("리포트를 생성중입니다")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12, weight: .heavy))
            }
            .padding(.top, 20)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("") {
                    }
                    .tint(Color.black)
                    .disabled(true)
                }
            }
            
#endif
        }
    }
}

#Preview {
    MeasuringCompleteView(onComplete: {})
}
