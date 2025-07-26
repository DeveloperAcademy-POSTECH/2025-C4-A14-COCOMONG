//
//  ReportDetailView.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct ReportDetailView: View {
    let selectedReport: CprReport
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                ReportDateTitle
                
                SummarySectionView(cprReport: selectedReport)
                
                PaceSectionView()
                
                DepthSectionView()
            }
            .padding(.horizontal, 16)
        }
        .background(Color.gray200)
    }
    
    private var ReportDateTitle: some View {
        Text(selectedReport.formattedDateWithoutYear)
            .font(.nanumSquareNeo(type: .extrabold, size: 24))
            .foregroundStyle(Color.black)
            .padding(.vertical, 10)
    }
}

//#Preview {
//    ReportDetailView()
//}
