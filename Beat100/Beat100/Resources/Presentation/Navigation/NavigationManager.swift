//
//  NavigationManager.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

@Observable final class NavigationManager: ObservableObject {
    var path = NavigationPath()
    
    func navigate(to destination: MeasurementGuide) {
        path.append(destination)
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func pop() {
        path.removeLast()
    }
}
