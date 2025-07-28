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
            + Text("약 5~6cm").font(.system(size: 14, weight: .bold))
            + Text("입니다. ")
            + Text("붉은 점은 압박의 깊이").font(.system(size: 14, weight: .bold)).foregroundColor(.beatDarkPink)
            + Text(", ")
            + Text("푸른 점은 이완의 깊이").font(.system(size: 14, weight: .bold)).foregroundColor(.beatTeal)
            + Text("를 나타냅니다. 일정하고 충분한 압박과 이완을 1:1로 유지하는 것이 중요합니다. 5~6cm 범위를 벗어난 압박 및 이완은 개선이 필요합니다.")
            )
        }
        .font(.system(size: 14, weight: .regular))
        .foregroundStyle(Color.black)
        .lineSpacing(3)
        .padding(.horizontal, 10)
    }
    
    private var DepthChartView: some View {
        let cycle = cprReport.cprCycleList[selectedIndex]
        let compressionPoints = cycle.depthSeries.filter { Int($0.compressionNumber) % 2 == 1 }
        let releasePoints = cycle.depthSeries.filter { Int($0.compressionNumber) % 2 == 0 }
        
        // 압박-이완 데이터를 짝으로 묶기
//        let pairedPoints: [(index: Int, compression: DepthPoint, release: DepthPoint)] =
//            zip(compressionPoints, releasePoints)
//                .enumerated()
//                .map { ($0.offset, $0.element.0, $0.element.1) }
        
        return Chart {
            // 압박-이완 연결선 (수평 LineMark)
//            ForEach(pairedPoints, id: \.compression.id) { pair in
//                LineMark(
//                    x: .value("Index", pair.index + 1),
//                    y: .value("압박", pair.compression.depth)
//                )
//                .interpolationMethod(.catmullRom)
//                .foregroundStyle(Color.gray600)
//                
//                LineMark(
//                    x: .value("Index", pair.index + 1),
//                    y: .value("이완", pair.release.depth)
//                )
//                .interpolationMethod(.catmullRom)
//                .foregroundStyle(Color.gray600)
//            }
            
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
        .chartYScale(domain: 2...9)
        .chartScrollableAxes(.horizontal)
        .frame(height: 150)
        .padding(.all, 20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
