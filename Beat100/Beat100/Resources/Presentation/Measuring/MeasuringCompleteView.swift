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
                TimelineView(.animation) { timeline in
                    let time = timeline.date.timeIntervalSinceReferenceDate
                    HStack {
                        ForEach(0..<3) { index in
                            Circle()
                                .frame(width: 16, height: 16)
                                .foregroundStyle(index == 0 ? .beatPink : index == 1 ? .beatGradPink : .beatBlue)
                                .offset(y: bounceOffset(for: index, time: time))
                                .padding(.trailing, index < 2 ? 15 : 0)
                        }
                    }
                    .frame(height: 130)
                }
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
                TimelineView(.animation) { timeline in
                    let time = timeline.date.timeIntervalSinceReferenceDate
                    HStack {
                        ForEach(0..<3) { index in
                            Circle()
                                .frame(width: 10, height: 10)
                                .foregroundStyle(index == 0 ? .beatPink : index == 1 ? .beatGradPink : .beatBlue)
                                .offset(y: bounceOffset(for: index, time: time))
                                .padding(.trailing, index < 2 ? 10 : 0)
                        }
                    }
                    .frame(height: 78)
                }
                Text("리포트를 생성중입니다")
                    .foregroundStyle(Color.white)
                    .font(.system(size: 12, weight: .heavy))
            }
            .padding(.top, 20)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("test") {
                        onComplete()
                    }
                    .tint(Color.black)
//                    .disabled(true)
                }
            }
            
#endif
        }
    }
    
    func bounceOffset(for index: Int, time: TimeInterval) -> CGFloat {
        let delay = Double(index) * 0.2
        return sin((time + delay) * 4) * 5
    }
}

#Preview {
    MeasuringCompleteView(onComplete: {})
}
