//
//  MeasuringView.swift
//  Beat100
//
//  Created by 나현흠 on 7/21/25.
//

import SwiftUI

struct MeasuringView: View {
    var body: some View {
        NavigationStack{
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
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        //TODO: 측정 취소
                    }) {
                        Text("취소")
                            .padding(.horizontal,4)
                            .font(.system(size: 15, weight: .semibold))
                    }
                    //TODO: 컬러칩 적용되면 gray900으로 변경
                    .background(Color.gray)
                    .cornerRadius(100)
                }
#endif
            }
        }
    }
}

#Preview {
    MeasuringView()
}
