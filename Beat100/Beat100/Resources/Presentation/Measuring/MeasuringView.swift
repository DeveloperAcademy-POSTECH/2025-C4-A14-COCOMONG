//
//  MeasuringView.swift
//  Beat100
//
//  Created by 나현흠 on 7/21/25.
//

import SwiftUI

struct MeasuringView: View {
    var onComplete: () -> Void
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea(.all)
            VStack{
                Image("MeasuringLogo")
                    .resizable()
                    .frame(width: {
#if os(iOS)
                        160
#elseif os(watchOS)
                        109
#else
                        160
#endif
                    }(), height: {
#if os(iOS)
                        136
#elseif os(watchOS)
                        93
#else
                        136
#endif
                    }())
                    .padding(.horizontal, 30)
                    .padding(.vertical, 18)
                
                Text("측정중...")
                    .padding(.top, 5)
                    .font(.system(size: {
#if os(iOS)
                        17.67
#elseif os(watchOS)
                        14
#else
                        14
#endif
                    }(), weight: .heavy))
            }
            .toolbar{
#if os(watchOS)
                    ToolbarItem(placement: .cancellationAction) {
                        Button("취소") {
                            //TODO: Navigation 실험용
                            onComplete()
                        }
                    }
#endif
            }
        }
    }
}

#Preview {
    MeasuringView(onComplete: {})
}
