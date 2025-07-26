//
//  BpmPoint+Convenience.swift.swift
//  Beat100
//
//  Created by oliver on 7/19/25.
//

import Foundation
import CoreData

extension CprReport {
    
    // MARK: - 옵셔널 벗겨내기 변수들
    // createdAt이 없을 경우 fallback으로 현재 시간 사용
    var safeCreatedAt: Date {
        createdAt ?? Date()
    }
    
    var cprCycleList: [CprCycle] {
        (cycles?.array as? [CprCycle]) ?? []
    }
    
    // TotalAccuracy 관련 안전 추출
    var correctCount: Int {
        Int(totalAccuracy?.correctNumber ?? 0)
    }
    
    var totalCount: Int {
        Int(totalAccuracy?.totalNumber ?? 0)
    }
    
    var percent: Int {
        Int(totalAccuracy?.percentage ?? 0)
    }
    
    var hasValidAccuracy: Bool {
        totalAccuracy != nil
    }
    
    // 날짜 스트링 포맷터 예시
    var formattedDateFull: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy년 M월 d일 (E) a h:mm"
        return formatter.string(from: safeCreatedAt)
    }
    
    var formattedDateWithoutYear: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "M월 d일 (E) a h:mm"
        return formatter.string(from: safeCreatedAt)
    }
    
    // MARK: - init 함수
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
