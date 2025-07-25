//
//  ExplainPressureCardView.swift
//  Beat100
//
//  Created by 이현주 on 7/25/25.
//

import SwiftUI

struct ExplainPressureCardView: View {
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 12)
                .stroke(.gray400, style: .init(lineWidth: 0.4))
                .foregroundStyle(Color.clear)
                
            ExplainPressureTextView
                .padding(.leading, 20)
                .padding(.vertical, 16)
        }
        .frame(height: 95)
        .frame(maxWidth: .infinity)
        .padding(.horizontal, 16)
    }
    
    private var ExplainPressureTextView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(Constants.ReportHomeText.explainPressureTitle)
            
            Text(Constants.ReportHomeText.explainPressureText)
                .lineSpacing(3)
        }
        .font(.system(size: 14, weight: .regular))
        .foregroundStyle(Color.gray800)
    }
}

#Preview {
    ExplainPressureCardView()
}
