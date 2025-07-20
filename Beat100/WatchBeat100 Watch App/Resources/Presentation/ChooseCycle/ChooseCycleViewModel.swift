//
//  ChooseCycleViewModel.swift
//  WatchBeat100 Watch App
//
//  Created by 나현흠 on 7/20/25.
//

import Foundation

class ChooseCycleViewModel: ObservableObject {
    @Published var selectedNumber: Int = 0
    @Published var showingInfo: Bool = false
}
