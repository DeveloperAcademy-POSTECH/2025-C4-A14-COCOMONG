//
//  DepthPoint+Convenience.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension DepthPoint {
    public convenience init(context: NSManagedObjectContext, id: UUID = UUID(), compressionNumber: Double, depth: Double) {
        self.init(context: context)
        self.id = id
        self.compressionNumber = compressionNumber
        self.depth = depth
    }
}
