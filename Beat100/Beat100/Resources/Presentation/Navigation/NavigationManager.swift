//
//  NavigationManager.swift
//  Beat100
//
//  Created by oliver on 7/22/25.
//

import SwiftUI

final class NavigationManager: ObservableObject {
    @Published var path = NavigationPath()
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    func pop() {
        path.removeLast()
    }
}
