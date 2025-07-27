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
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ExplainPressureCardView()
                    
                    YearMonthReportCardListView
                }
                .padding(.all, 16)
                .padding(.bottom, 20)
                .navigationTitle(Constants.ReportHomeText.navTitle)
                .navigationBarTitleDisplayMode(.large)
                .task { // extension 메서드로 전체 리포트 가져오기
                    do {
                        let allReports = try CprReport.fetchAll(in: context)
                        groupedReports = try CprReport.groupedByYearMonth(cprReports: allReports)
                        print("CPR Reports loaded: \(allReports.count)")
                    } catch {
                        print("Failed to load reports: \(error)")
                    }
                }
            }
            .background(Color.gray200)
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
        VStack(alignment: .leading, spacing: 20) {
            Text(dateString)
                .font(.nanumSquareNeo(type: .heavy, size: 18))
                .foregroundStyle(Color.gray800)
                .padding(.leading, 8)
            
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(reports, id: \.self) { (report: CprReport) in
                    NavigationLink(
                        destination: ReportDetailView(
                            selectedReport: report)
                    ) {
                        ReportSummaryCardView(
                            measureDate: report.formattedDateFull,
                            total: report.totalCount,
                            count: report.correctCount,
                            percent: report.percent
                        )
                    }
                }
            }
        }
    }
}

#Preview {
    ReportHomeView()
}
