//
//  AppState.swift
//  Beat100
//
//  Created by 나현흠 on 7/28/25.
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    @Published var showingMeasuringModal = false
    @Published var selectedNumber: Int = 1
}
