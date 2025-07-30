//
//  ChooseCycleView.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/16/25.
//

import SwiftUI

struct ChooseCycleView: View {
    @State var selectedNumber: Int = 1
    @ObservedObject var viewModel: ChooseCycleViewModel = .init()
    let ConnectivityManager = WatchConnectivityManager.shared
    
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
                .background(
                    PickerGradientBackgroundColor()
                )
                .clipShape(RoundedRectangle(cornerRadius: 13))
                .overlay(
                    PickerGradientOverlay()
                )
                .labelsHidden()
                .pickerStyle(.wheel)
                
                VStack{
                    LargeActionButton(title: "시작") {
                        viewModel.showingMeasuringModal.toggle()
                        ConnectivityManager.sendMessage([
                            "MeasureStartFlag": true,
                            "selectedNumber": selectedNumber
                        ])
                    }
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
