//
//  ChooseCycleView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/16/25.
//

import SwiftUI

struct ChooseCycleView: View {
    @State var selectedNumber: Int = 1
    @ObservedObject var viewModel: ChooseCycleViewModel
    let manager = WatchConnectivityManager.shared
    
    var body: some View {
        NavigationStack{
            VStack{
                Text("사이클")
                    .font(.nanumSquareNeo(type: .heavy, size: 16))
                Picker("숫자 선택", selection: $selectedNumber) {
                    ForEach(1...5, id: \.self) { number in
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
                        viewModel.showingMeasuringModal.toggle()
                        manager.sendMessage([
                            "MeasureStartFlag": true,
                            "selectedNumber": selectedNumber
                        ])
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
            .fullScreenCover(isPresented: $viewModel.showingWatchStart){
                WatchStartView()
                    .interactiveDismissDisabled(true)
            }
            .fullScreenCover(isPresented: $viewModel.showingMeasuringModal){
                MeasuringFlowView(selectedNumber: selectedNumber)
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
    }
}

#Preview {
    ChooseCycleView(viewModel: ChooseCycleViewModel())
}
