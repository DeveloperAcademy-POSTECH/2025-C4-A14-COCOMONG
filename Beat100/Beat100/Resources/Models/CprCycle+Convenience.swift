//
//  BpmPoint+Convenience.swift.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension CprCycle {
    public convenience init(context: NSManagedObjectContext, accuracy: CycleAccuracy, bpmPoints: NSSet, depthPoints: NSSet) {
        self.init(context: context)
        self.accuracy = accuracy
        self.bpmPoints = bpmPoints
        self.depthPoints = depthPoints
    }
    
    public var bpmSeries: [BpmPoint] {
        (bpmPoints as? Set<BpmPoint>)?.sorted(by: { $0.time < $1.time }) ?? []
    }
    
    public var depthSeries: [DepthPoint] {
        (depthPoints as? Set<DepthPoint>)?.sorted(by: { $0.compressionNumber < $1.compressionNumber }) ?? []
    }
}
