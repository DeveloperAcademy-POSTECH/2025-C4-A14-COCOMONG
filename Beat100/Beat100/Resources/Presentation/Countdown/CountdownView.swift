//
//  CountdownView.swift
//  Beat100
//
//  Created by 나현흠 on 7/18/25.
//

import SwiftUI

struct CountdownView: View {
    let startTime: Date
    @Binding var isCountdownDone: Bool
    @State var now: Date = Date()
    
    var countdown: Int {
        max(0, Int(ceil(startTime.timeIntervalSince(now))))
    }
    
    var body: some View {
        ZStack{
            Color.black
                    .ignoresSafeArea()
            
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
            
            Text("\(countdown)")
                .font(.nanumSquareNeo(type: .heavy, size: 50))
                .foregroundColor(.white)
                .onReceive(Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()) { time in
                    now = time
                    if countdown <= 0 {
                        isCountdownDone = true
                    }
                }
        }
    }
}

#Preview {
    CountdownView(
        startTime: Date().addingTimeInterval(5),
        isCountdownDone: .constant(false)
    )
}
