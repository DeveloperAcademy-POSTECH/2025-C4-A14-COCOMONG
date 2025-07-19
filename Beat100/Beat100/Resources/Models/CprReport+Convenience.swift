//
//  BpmPoint+Convenience.swift.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension CprReport {
    public convenience init(context: NSManagedObjectContext, createdAt: Date, totalAccuracy: TotalAccuracy, numberOfCycles: Int16, cycles: [CprCycle]) {
        self.init(context: context)
        self.createdAt = createdAt
        self.totalAccuracy = totalAccuracy
        self.numberOfCycles = numberOfCycles
        self.cycles = NSOrderedSet(array: cycles)
    }
}
