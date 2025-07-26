//
//  BpmPoint+Convenience.swift.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension CprCycle {
    public convenience init(context: NSManagedObjectContext, id: UUID = UUID(), accuracy: CycleAccuracy, bpmPoints: NSSet, depthPoints: NSSet) {
        self.init(context: context)
        self.id = id
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
    
    public var correctCount: Int {
        Int(accuracy?.correctNumber ?? 0)
    }
    
    public var totalCount: Int {
        Int(accuracy?.totalNumber ?? 0)
    }
    
    public var percent: Int {
        Int(accuracy?.percentage ?? 0)
    }
    
    public var hasValidAccuracy: Bool {
        accuracy != nil && totalCount > 0
    }
}
