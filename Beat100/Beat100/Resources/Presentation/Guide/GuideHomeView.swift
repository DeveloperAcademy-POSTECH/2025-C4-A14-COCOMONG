//
//  SwiftUIView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct GuideHomeView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        VStack {
            Button("Apple Watch에서 CPR 측정하기") {
                isPresented.toggle()
            }
            Text("CPR 전체 가이드라인")
        }
        .sheet(isPresented: $isPresented) {
            VStack {
                BackCancel(isPresented: $isPresented)
                Spacer()
                LargeButton(text: "계속") {
                }
            }
        }
    }
    
}

#Preview {
    GuideHomeView()
}
