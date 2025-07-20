//
//  DepthPoint+Convenience.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension DepthPoint {
    public convenience init(context: NSManagedObjectContext, compressionNumber: Double, depth: Double) {
        self.init(context: context)
        self.compressionNumber = compressionNumber
        self.depth = depth
    }
}
