//
//  SummarySectionView.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import SwiftUI

struct SummarySectionView: View {
    let cprReport: CprReport
    
    var body: some View {
        DetailSectionView(title: "요약") {
            SummarySectionDetailView
        }
    }
    
    private var SummarySectionDetailView: some View {
        VStack(spacing: 20) {
            
            CycleSummaryCellView(cycleTitle: "전체 사이클", totalCount: cprReport.totalCount, correctCount: cprReport.correctCount, percent: cprReport.percent)
                .padding(.horizontal, 20)
                .padding(.vertical, 16)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            customCycleListView
        }
    }
    
    private var customCycleListView: some View {
        VStack(spacing: 0) {
            ForEach(Array(cprReport.cprCycleList.enumerated()), id: \.element.id) { (index, cycle) in
                VStack(spacing: 0) {
                    CycleSummaryCellView(
                        cycleTitle: "\(index + 1) 사이클",
                        totalCount: cycle.totalCount,
                        correctCount: cycle.correctCount,
                        percent: cycle.percent
                    )
                    .padding(.horizontal, 20)
                    .padding(.vertical, 16)

                    if index < cprReport.cprCycleList.count - 1 {
                        Divider()
                            .padding(.horizontal, 16)
                    }
                }
            }
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
