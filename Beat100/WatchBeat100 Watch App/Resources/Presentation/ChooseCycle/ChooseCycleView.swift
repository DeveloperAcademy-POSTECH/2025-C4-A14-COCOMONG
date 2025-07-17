//
//  ChooseCycleView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/16/25.
//

import SwiftUI

struct ChooseCycleView: View {
    @State private var selectedNumber: Int = 0
    @State private var showingInfo: Bool = false
    let numbers = Array(1...5)
    
    var body: some View {
        VStack{
            HStack{
                Button(action: {
                    showingInfo = true
                }) {
                    Image(systemName: "info")
                }
                .frame(width: 34, height: 34)
                .clipShape(Circle())
                Spacer()
            }
            .padding(.leading, 9)
            
            Text("사이클")
                .font(.nanumSquareNeo(type: .heavy, size: 16))
            Picker("숫자 선택", selection: $selectedNumber) {
                ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                            .font(.nanumSquareNeo(type: .heavy, size: 28))
                            .tag(number)
                    
                }
            }
            .frame(width: 85, height: 85)
            .background(LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: .beatPink, location: 0.0),
                    .init(color: .beatPink, location: 0.25), // 첫 번째 색상을 70%까지 유지
                    .init(color: .beatBlue, location: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            ).opacity(0.25)
            )
            .clipShape(RoundedRectangle(cornerRadius: 13))
            .overlay(
                RoundedRectangle(cornerRadius: 13)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .beatPink, location: 0.0),
                                .init(color: .beatPink, location: 0.24), // 첫 번째 색상을 70%까지 유지
                                .init(color: .beatBlue, location: 1.0)
                            ]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        ),
                        lineWidth: 2
                    )
                    .frame(width:84, height:84)
            )
            .labelsHidden()
            .pickerStyle(.wheel)
            
            VStack{
                Button(action: {
                    // 액션
                }) {
                    Text("시작")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundStyle(.black)
                }
                .frame(width: 164, height: 51)
                .background(.beatBlue)
                .clipShape(RoundedRectangle(cornerRadius: 100))
            }
            .padding(.top, 8)
            .padding(.bottom, 13)
        }
        .sheet(isPresented: $showingInfo) {
            ChooseCycleInfoView()
        }
    }
}

#Preview {
    ChooseCycleView()
}
