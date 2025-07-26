//
//  ReportDetailView.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct ReportDetailView: View {
    let selctedReport: CprReport
    
    var body: some View {
        if let total = selctedReport.totalAccuracy?.totalNumber {
            Text("\(total)")
        }
    }
}

//#Preview {
//    ReportDetailView()
//}
