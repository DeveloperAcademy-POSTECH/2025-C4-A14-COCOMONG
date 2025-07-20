//
//  BpmPoint+Convenience.swift.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension CycleAccuracy {
    public convenience init(context: NSManagedObjectContext, correctNumber: Int16, totalNumber: Int16) {
        self.init(context: context)
        self.correctNumber = correctNumber
        self.totalNumber = totalNumber
        self.percentage = Double(correctNumber) / Double(totalNumber) * 100
    }
}
