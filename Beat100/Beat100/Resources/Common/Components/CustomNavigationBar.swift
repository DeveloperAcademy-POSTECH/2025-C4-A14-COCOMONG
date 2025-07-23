//
//  CustomNavigationBar.swift
//  Beat100
//
//  Created by 이현주 on 7/23/25.
//

import SwiftUI
import UIKit

struct CustomNavigationBar<Title: View>: View {
    
    @Environment(\.dismiss) private var dismiss
    
    private let title: Title
    
    init(
      @ViewBuilder title: () -> Title = { EmptyView() }
    ) {
      self.title = title()
    }

    
    var body: some View {
        ZStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .fontWeight(.bold)
                }
                .frame(width: 44, height: 44)
                Spacer()
                
                Rectangle()
                    .frame(width: 44, height: 44)
                    .foregroundColor(Color.clear)
            }
            .padding(.horizontal, 16)
            
            title
                .font(.system(size: 16, weight: .bold))
                .lineSpacing(6)
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity)
                .accessibilityAddTraits(.isHeader)
        }
        .foregroundStyle(Color.black)
        .padding(.top, 32)
        .background(Color.gray200)
    }
    
    private var topSafeAreaInset: CGFloat {
        UIApplication.shared.connectedScenes
            .compactMap { ($0 as? UIWindowScene)?.windows.first?.safeAreaInsets.top }
            .first ?? 0
    }
}

// MARK: - 뒤로가기 스와이프
extension UINavigationController: @retroactive UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

#Preview {
  ZStack {
    Color.white
      VStack {
          CustomNavigationBar(
            title: { Text("2025년 7월 17일 (목)\n오후 4:58") }
          )
          Spacer()
      }
  }
}
