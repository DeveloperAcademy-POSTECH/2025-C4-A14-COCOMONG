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
            Rectangle()
                .stroke(.clear)
                .background(Color.white)
                
            ExplainPressureTextView
                .padding(.leading, 20)
                .padding(.vertical, 16)
        }
        .frame(height: 95)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
    private var ExplainPressureTextView: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(Constants.ReportHome.explainPressureTitle)
            
            Text(Constants.ReportHome.explainPressureText)
                .lineSpacing(3)
        }
        .font(.system(size: 14, weight: .regular))
        .foregroundStyle(Color.gray800)
    }
}

#Preview {
    ExplainPressureCardView()
}
