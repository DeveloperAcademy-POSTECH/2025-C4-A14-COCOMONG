//
//  RootFlowView.swift
//  Beat100
//
//  Created by 나현흠 on 7/28/25.
//

import SwiftUI

struct RootFlowView: View {
    @AppStorage("hasSeenGuide") var hasSeenGuide: Bool = false
    
    var body: some View {
        if hasSeenGuide {
            ChooseCycleView()
        } else {
            BeforeWatchView()
        }
    }
}
