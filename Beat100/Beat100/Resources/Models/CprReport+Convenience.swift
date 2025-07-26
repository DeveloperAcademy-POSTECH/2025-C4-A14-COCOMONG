//
//  BpmPoint+Convenience.swift.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension CprReport {
    public convenience init(context: NSManagedObjectContext, id: UUID = UUID(), createdAt: Date, totalAccuracy: TotalAccuracy, numberOfCycles: Int16, cycles: [CprCycle]) {
        self.init(context: context)
        self.id = id
        self.createdAt = createdAt
        self.totalAccuracy = totalAccuracy
        self.numberOfCycles = numberOfCycles
        self.cycles = NSOrderedSet(array: cycles)
    }
    
    // MARK: - CprReport Create (of CRUD)
    @MainActor
    static func create(
        context: NSManagedObjectContext,
        totalAccuracy: TotalAccuracy,
        numberOfCycles: Int16,
        cycles: [CprCycle]
    ) async throws -> CprReport {
        let report = CprReport(
            context: context,
            createdAt: Date(),
            totalAccuracy: totalAccuracy,
            numberOfCycles: numberOfCycles,
            cycles: cycles
        )
        
        do {
            try context.save()
            return report
        } catch {
            context.rollback()
            throw error
        }
    }
    
    // MARK: - CPRReport Read ALL (of CRUD)
    static func fetchAll(in context: NSManagedObjectContext) throws -> [CprReport] {
        let request: NSFetchRequest<CprReport> = CprReport.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CprReport.createdAt, ascending: true)]
        return try context.fetch(request)
    }
    
    // MARK: - Group by Year-Month
    static func groupedByYearMonth(cprReports: [CprReport]) throws -> [String: [CprReport]] {
        let calendar = Calendar.current
        
        let grouped = Dictionary(grouping: cprReports) { report -> String in
            let date = report.createdAt ?? Date()
            let components = calendar.dateComponents([.year, .month], from: date)
            return String(format: "%04d년 %02d월", components.year ?? 0, components.month ?? 0)
        }
        
        return grouped
    }
}
