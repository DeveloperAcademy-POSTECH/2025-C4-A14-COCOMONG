//
//  ReportHomeView.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct ReportHomeView: View {
    @Environment(\.managedObjectContext) private var context
    @State private var groupedReports: [String: [CprReport]] = [:]
    
    private let readableKoreanFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "ko_KR")
        f.dateFormat = "yyyy년 M월 d일 (E) a h:mm"
        return f
    }()
    
    var body: some View {
        NavigationView {
            Group {
                if groupedReports.isEmpty {
                    NoReportTextView
                } else {
                    ScrollView {
                        VStack(spacing: 20) {
                            ExplainPressureCardView()
                            YearMonthReportCardListView
                        }
                        .padding(.all, 16)
                        .padding(.bottom, 20)
                    }
                }
            }
            .navigationTitle(Constants.ReportHome.navTitle)
            .navigationBarTitleDisplayMode(.large)
            .task {
                do {
                    let allReports = try CprReport.fetchAll(in: context)
                    groupedReports = try CprReport.groupedByYearMonth(cprReports: allReports)
                    print("CPR Reports loaded: \(allReports.count)")
                } catch {
                    print("Failed to load reports: \(error)")
                }
            }
        }
    }
    
    private var YearMonthReportCardListView: some View {
        LazyVStack(alignment: .leading, spacing: 20) {
            ForEach(groupedReports.keys.sorted(by: >), id: \.self) { dateString in
                SectionView(dateString: dateString, reports: groupedReports[dateString] ?? [])
            }
        }
    }
    
    
    private func SectionView(dateString: String, reports: [CprReport]) -> some View {
        let sortedReports = reports.sorted {
            guard let date1 = $0.createdAt, let date2 = $1.createdAt else { return false }
            return date1 > date2 // 최신 순 정렬
        }
        
        return VStack(alignment: .leading, spacing: 20) {
            Text(dateString)
                .font(.nanumSquareNeo(type: .heavy, size: 18))
                .foregroundStyle(Color.gray800)
                .padding(.leading, 8)
            
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(sortedReports, id: \.self) { (report: CprReport) in
                    if let createdAt = report.createdAt,
                       let total = report.totalAccuracy?.totalNumber,
                       let correct = report.totalAccuracy?.correctNumber,
                       let percent = report.totalAccuracy?.percentage {
                        
                        NavigationLink(destination: ReportDetailView(selectedReport: report)) {
                            ReportSummaryCardView(
                                measureDate: readableKoreanFormatter.string(from: createdAt),
                                total: Int(total),
                                count: Int(correct),
                                percent: Int(percent)
                            )
                        }
                    }
                }
            }
        }
    }
    
    private var NoReportTextView: some View {
        Text(Constants.ReportHome.noReportText)
            .multilineTextAlignment(.center)
            .font(.nanumSquareNeo(type: .heavy, size: 16))
            .foregroundStyle(Color.gray800)
            .lineSpacing(8)
    }
}
