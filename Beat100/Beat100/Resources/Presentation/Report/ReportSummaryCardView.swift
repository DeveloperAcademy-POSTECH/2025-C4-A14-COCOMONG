//
//  ReportSummaryCardView.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI

struct ReportSummaryCardView: View {
    let measureDate: String
    let total: Int
    let count: Int
    let percent: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray400, style: .init(lineWidth: 0.4))
                .foregroundStyle(Color.white)
                
            
            CardContentView
        }
        // LazyVStack or VGrid 만들 때 수정
        .frame(height: 150)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
    
    private var CardContentView: some View {
        VStack(alignment: .leading) {
            // 날짜
            Text(measureDate)
                .foregroundStyle(Color.gray700)
                .font(.system(size: 16, weight: .regular))
            
            Spacer()
            
            ReportSummaryView
        }
        .padding(.all, 20)
    }
    
    private var ReportSummaryView: some View {
        HStack {
            PressureCountView
            
            Spacer()
            
            // TODO: - CircleProgressView 그라데이션 색상 변경
            CustomCircleProgressView(progress: percent)
        }
    }
    
    private var PressureCountView: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("정확한 압박")
                .foregroundStyle(Color.gray900)
                .font(.system(size: 18, weight: .bold))
            
            Text("\(count)/\(total)회")
                .foregroundStyle(.beatTeal)
                .font(.nanumSquareNeo(type: .extrabold, size: 22))
        }
    }
}

#Preview {
    ReportSummaryCardView(measureDate: "2025년 7월 17일 (목) 오후 4:58", total: 120, count: 110, percent: 92)
}
