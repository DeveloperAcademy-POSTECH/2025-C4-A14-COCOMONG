//
//  SourceCheckView.swift
//  Beat100
//
//  Created by 나현흠 on 7/22/25.
//

import SwiftUI

struct AccelerationData: Codable, Identifiable {
    var id: TimeInterval { timestamp } // For List
    let zValue: Double
    let timestamp: Double
}

struct SourceCheckView: View {
    @State private var iosshowingMeasuringModal: Bool = false
    @State private var MeasureLogs: [AccelerationData] = []
    @State private var TextAmount: Int = 0
    @State var selectedNumber: Int = 1
    
    var body: some View {
        VStack{
            Text("가속도 측정값 정리")
            Button("modal test"){
                iosshowingMeasuringModal.toggle()
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(MeasureLogs) { data in
                        Text("Z: \(data.zValue), t: \(data.timestamp)")
                            .padding(.bottom, 4)
                    }
                }
                .padding()
            }
            
            .onAppear {
                print("SourceCheckView onAppear called")
                
                NotificationCenter.default.addObserver(forName: Notification.Name("selectedNumberNotification"), object: nil, queue: .main, using: { notification in
                    if let userInfo = notification.userInfo {
                        if let selectedNum = userInfo["selectedNumber"] as? Int {
                            selectedNumber = selectedNum
                            print("selectedNumber on iOS: \(selectedNum)")
                        }
                    }
                }
                )
                
                NotificationCenter.default.addObserver(forName: Notification.Name("MeasureStartNotification"), object: nil, queue: .main) { notification in
                    print("MeasureStart Notification received!")
                    iosshowingMeasuringModal.toggle()
                }
                
                //MARK: 측정값 잘 들어와서 뷰에 잘 보여지나 보기 위한 기능 (뺄 예정)
                
                NotificationCenter.default.addObserver(forName: Notification.Name("didReceiveAllLogs"), object: nil, queue: .main) { notification in
                    print("Notification received!")
                    
                    if let json = notification.userInfo?["allLogs"] as? String,
                       let data = json.data(using: .utf8),
                       let parsed = try? JSONDecoder().decode([AccelerationData].self, from: data) {
                        self.MeasureLogs = parsed
                        print("\(parsed.count) items")
                    } else {
                        print("디코딩 실패")
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $iosshowingMeasuringModal){
            iOSMeasuringFlowView(selectedNumber: selectedNumber)
        }
    }
}

#Preview {
    SourceCheckView()
}
