//
//  SwiftUIView.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

struct SwiftUIView: View {
    @State var isPresented: Bool = false
    
    var body: some View {
        Button(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/) {
            isPresented.toggle()
        }
        .sheet(isPresented: $isPresented) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
    }
    
}

#Preview {
    SwiftUIView()
}
