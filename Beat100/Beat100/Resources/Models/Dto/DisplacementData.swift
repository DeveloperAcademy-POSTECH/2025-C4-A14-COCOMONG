//
//  DisplacementData.swift
//  Beat100
//
//  Created by 이현주 on 7/27/25.
//

import Foundation

struct DisplacementData: Identifiable {
    let timestamp: TimeInterval
    let displacement: Double
    
    var id: TimeInterval { timestamp }
}
