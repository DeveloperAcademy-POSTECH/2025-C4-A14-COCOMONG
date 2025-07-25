//
//  SourceCheckView.swift
//  Beat100
//
//  Created by 나현흠 on 7/22/25.
//

import SwiftUI

struct AccelerationData: Codable, Identifiable {
    var id: TimeInterval { timestamp } // For List
    let user_acc_z: Double
    let timestamp: TimeInterval
}

struct SourceCheckView: View {
    @State private var iosshowingMeasuringModal: Bool = false
    @State private var zLogData: [AccelerationData] = []
    @State var selectedNumber: Int = 1

    var body: some View {
        VStack{
            Text("가속도 측정값 정리")
            Button("modal test"){
                iosshowingMeasuringModal.toggle()
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(zLogData) { data in
                        Text("Z: \(data.user_acc_z), t: \(data.timestamp)")
                            .padding(.bottom, 4)
                    }
                }
                .padding()
            }
//            .onAppear {
//                print("SourceCheckView onAppear called")
//                
//                NotificationCenter.default.addObserver(forName: Notification.Name("didReceiveAllLogs"), object: nil, queue: .main) { notification in
//                    print("Notification received!")
//                    
//                    if let json = notification.userInfo?["allLogs"] as? String,
//                       let data = json.data(using: .utf8),
//                       let stringArray = try? JSONDecoder().decode([String].self, from: data) {
//                        print("Decoded [String] with \(stringArray.count) items")
//                        
//                        let parsed = stringArray.enumerated().compactMap { index, value -> AccelerationData? in
//                            let raw = value.replacingOccurrences(of: "Z값: ", with: "")
//                            if let z = Double(raw) {
//                                return AccelerationData(user_acc_z: z, timestamp: TimeInterval(index))
//                            } else {
//                                return nil
//                            }
//                        }
//                        
//                        self.zLogData = parsed
//                        print("zLogData updated with \(parsed.count) items")
//                    } else {
//                        print("[String] 디코딩 실패")
//                    }
//                }
//            }
            
            .onAppear {
                print("SourceCheckView onAppear called")
                
                NotificationCenter.default.addObserver(forName: Notification.Name("MeasureStartNotification"), object: nil, queue: .main) { notification in
                    print("Notification received!")
                    iosshowingMeasuringModal.toggle()
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
