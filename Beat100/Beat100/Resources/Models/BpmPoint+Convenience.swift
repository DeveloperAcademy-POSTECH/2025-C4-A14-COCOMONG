//
//  BpmPoint+Convenience.swift.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension BpmPoint {
    public convenience init(context: NSManagedObjectContext, id: UUID = UUID(), time: Double, bpm: Double) {
        self.init(context: context)
        self.id = id
        self.time = time
        self.bpm = bpm
    }
}
