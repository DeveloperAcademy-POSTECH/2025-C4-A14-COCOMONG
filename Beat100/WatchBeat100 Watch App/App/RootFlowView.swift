//
//  RootFlowView.swift
//  Beat100
//
//  Created by 나현흠 on 7/28/25.
//

import SwiftUI

struct RootFlowView: View {
    var isGuideFinish: Bool
    
    var body: some View {
        if isGuideFinish {
            ChooseCycleView()
        } else {
            BeforeWatchView()
        }
    }
}
