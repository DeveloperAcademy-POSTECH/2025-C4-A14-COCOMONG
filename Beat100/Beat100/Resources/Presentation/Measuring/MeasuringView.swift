//
//  MeasuringView.swift
//  Beat100
//
//  Created by 나현흠 on 7/21/25.
//

import SwiftUI

struct MeasuringView: View {
    @Binding var selectedNumber: Int
    var onComplete: () -> Void
    
    @State private var beatAnimation = false
    let cycle = 60.0 / 220.0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                (beatAnimation ? Color.pink : Color.black)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: cycle / 3), value: beatAnimation)
                
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color(red: 0.11, green: 0.97, blue: 1), location: 0.2),
                                .init(color: Color(red: 0.98, green: 0.34, blue: 0.55), location: 0.45),
                            ]),
                            center: .center,
                            startRadius: 0,
                            endRadius: beatAnimation ? geometry.size.width * 1.0 : geometry.size.width * 0.1
                        )
                    )
                    .frame(width: beatAnimation ? geometry.size.width * 1.5 : geometry.size.width * 0.15,
                           height: beatAnimation ? geometry.size.width * 1.5 : geometry.size.width * 0.15)
                    .opacity(beatAnimation ? 1.0 : 0)
                    .blur(radius: beatAnimation ? 30 : 20)
                    .animation(.easeInOut(duration: cycle / 3), value: beatAnimation)
                
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .scaleEffect(beatAnimation ? 0.1 : 0.25)
                    .foregroundColor(beatAnimation ? .pink : .black)
                    .shadow(color: .white.opacity(0.9), radius: 15)
                    .animation(.spring(response: 0.4, dampingFraction: 0.5), value: beatAnimation)
            }
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: cycle, repeats: true) { _ in
                beatAnimation.toggle()
            }
        }
        .disabledToolbar()
    }
}

#Preview {
    MeasuringView(selectedNumber: .constant(1), onComplete: {})
}
