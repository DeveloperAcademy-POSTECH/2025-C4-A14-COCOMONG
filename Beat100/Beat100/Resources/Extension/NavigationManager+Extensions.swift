//
//  NavigationManager+Extensions.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import Foundation

extension NavigationManager {
    func navigate(to destination: MeasurementGuide) {
        path.append(destination)
    }
}
