//
//  ChooseCycleView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/16/25.
//

import SwiftUI

struct ChooseCycleView: View {
    @StateObject var viewModel = ChooseCycleViewModel()
    let numbers = Array(1...5)
    
    var body: some View {
#if os(iOS)
        ZStack{
            Color.black
                .ignoresSafeArea(edges: .all)
            Text("Apple Watch에서\nCPR 사이클을 선택하세요")
                .font(.system(size:20, weight: .regular))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center)
        }
#elseif os(watchOS)
        NavigationStack{
            VStack{
                Text("사이클")
                    .font(.nanumSquareNeo(type: .heavy, size: 16))
                Picker("숫자 선택", selection: $viewModel.selectedNumber) {
                    ForEach(numbers, id: \.self) { number in
                        Text("\(number)")
                            .font(.nanumSquareNeo(type: .heavy, size: 28))
                            .tag(number)
                    }
                }
                .defaultWheelPickerItemHeight(40)
                .frame(width: 85, height: 85)
                .background(LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: .beatPink, location: 0.0),
                        .init(color: .beatPink, location: 0.25),
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
                                    .init(color: .beatPink, location: 0.25),
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
                        //TODO: ReadyMainView로 이동
                    }) {
                        Text("시작")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(.black)
                    }
                    
                    .background(.beatBlue)
                    .clipShape(RoundedRectangle(cornerRadius: 100))
                }
                .padding(.top, 8)
                .padding(.bottom, 12.5)
            }
            .sheet(isPresented: $viewModel.showingInfo) {
                ChooseCycleInfoView()
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button{
                        viewModel.showingInfo = true
                    } label: {
                        Image(systemName: "info")
                    }
                }
            }
        }
#endif
    }
}

#Preview {
    ChooseCycleView()
}
