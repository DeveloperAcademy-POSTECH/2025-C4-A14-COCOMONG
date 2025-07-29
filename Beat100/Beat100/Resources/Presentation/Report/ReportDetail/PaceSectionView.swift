//
//  PaceSectionView.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import SwiftUI
import Charts

struct PaceSectionView: View {
    let cprReport: CprReport
    var cycleMenu: [String] {
        let n = min(cprReport.cycleNums, cprReport.cprCycleList.count)
        return (1...n).map { "\($0) 사이클" }
    }
    
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        DetailSectionView(title: "속도", trailingTopView: {
            Picker("사이클 선택", selection: $selectedIndex) {
                ForEach(0..<cycleMenu.count, id: \.self) { index in
                    Text(cycleMenu[index])
                }
            }
            .tint(Color.beatTeal)
        }) {
            PaceSectionDetailView
        }
    }
    
    private var PaceSectionDetailView: some View {
        VStack(spacing: 16) {
            PaceChartView
            
            Text(Constants.ReportDetail.paceContent)
                .font(.system(size: 14, weight: .regular))
                .padding(.horizontal, 10)
                .lineSpacing(3)
        }
    }
    
    private var PaceChartView: some View {
        return Chart {
            // 기준선 (110)
            RuleMark(y: .value("Threshold", 110))
                .lineStyle(StrokeStyle(lineWidth: 1))
                .foregroundStyle(Color.beatDarkPink)
            
            ForEach(Array(cprReport.cprCycleList[selectedIndex].bpmSeries.enumerated()), id: \.offset) { index, point in
                LineMark(
                    x: .value("횟수", index + 1),
                    y: .value("BPM", point.bpm)
                )
                PointMark(
                    x: .value("횟수", index + 1),
                    y: .value("BPM", point.bpm)
                )
                .interpolationMethod(.monotone)
            }
        }
        // Y축 110만 highlight
        .chartYAxis {
            AxisMarks(position: .leading) { value in
                AxisGridLine()
                
                AxisValueLabel() {
                    if let intValue = value.as(Int.self) {
                        Text("\(intValue)")
                            .foregroundColor(intValue == 110 ? Color.beatDarkPink : .gray)
                    }
                }
            }
        }
        .chartXScale(domain: 0...31)
        .chartYScale(domain: 90...130)
        .chartScrollableAxes(.horizontal)
        .frame(height: 150)
        .padding(.all, 20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
