//
//  DepthSectionView.swift
//  Beat100
//
//  Created by 이현주 on 7/26/25.
//

import SwiftUI
import Charts

struct DepthSectionView: View {
    let cprReport: CprReport
    var cycleMenu: [String] {
        (1...cprReport.cycleNums).map { "\($0) 사이클" }
    }
    @State private var selectedIndex: Int = 0
    
    var body: some View {
        VStack {
            DetailSectionView(title: "깊이", trailingTopView: {
                Picker("사이클 선택", selection: $selectedIndex) {
                    ForEach(0..<cycleMenu.count, id: \.self) { index in
                        Text(cycleMenu[index])
                    }
                }
                .tint(Color.beatTeal)
            }) {
                DepthSectionDetailView
            }
        }
    }
    
    private var DepthSectionDetailView: some View {
        VStack(spacing: 16) {
            DepthChartView
            
            depthContentView
        }
    }
    
    private var depthContentView: some View {
        Group {
            (
            Text("권장 압박 깊이는 ")
            + Text("약 5~6cm").font(.system(size: 15, weight: .bold))
            + Text("입니다.\n")
            + Text("붉은 점은 압박의 깊이").font(.system(size: 15, weight: .bold)).foregroundColor(.beatDarkPink)
            + Text(", ")
            + Text("푸른 점은 이완의 깊이").font(.system(size: 15, weight: .bold)).foregroundColor(.beatTeal)
            + Text("입니다. 일정하고 충분한 압박과 이완을 1:1로 유지하는 것이 중요합니다. 5~6cm 범위를 벗어난 압박 및 이완은 개선이 필요합니다.")
            )
        }
        .font(.system(size: 15, weight: .regular))
        .foregroundStyle(Color.black)
        .lineSpacing(3)
        .padding(.horizontal, 10)
    }
    
    private var DepthChartView: some View {
        let cycle = cprReport.cprCycleList[selectedIndex]
        let compressionPoints = cycle.depthSeries.filter { Int($0.compressionNumber) % 2 == 1 }
        let releasePoints = cycle.depthSeries.filter { Int($0.compressionNumber) % 2 == 0 }
        
        return Chart {
            // 압박 점
            ForEach(Array(compressionPoints.enumerated()), id: \.element.id) { index, point in
                PointMark(
                    x: .value("압박 횟수", index + 1),
                    y: .value("압박 깊이", point.depth)
                )
                .foregroundStyle(Color.beatDarkPink)
            }

            // 이완 점
            ForEach(Array(releasePoints.enumerated()), id: \.element.id) { index, point in
                PointMark(
                    x: .value("이완 횟수", index + 1),
                    y: .value("이완 깊이", point.depth)
                )
                .foregroundStyle(Color.beatMint)
            }
        }
        .chartXScale(domain: 0...31)
        .chartYScale(domain: 3.5...7.5)
        .chartYAxis {
            AxisMarks(values: [5, 6]) { value in
                AxisGridLine()
                AxisTick()
                AxisValueLabel()
            }
        }
        .chartScrollableAxes(.horizontal)
        .frame(height: 150)
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
