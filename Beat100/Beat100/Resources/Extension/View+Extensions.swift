//
//  View+Extensions.swift
//  Beat100
//
//  Created by oliver on 7/27/25.
//

import Foundation
import SwiftUICore
import UIKit

extension View {
    /// Figma 상의 lineHeight로 lineSpacing을 계산해서 적용합니다.
    /// - Parameters:
    ///     - font: 적용할 폰트 (UIFont)
    ///     - lineHeight: figma 상의 lineHeight
    func fontWithLineHeight(font: UIFont, lineHeight: CGFloat) -> some View {
        self.modifier(FontWithLineHeight(font: font, lineHeight: lineHeight))
    }
}

struct FontWithLineHeight: ViewModifier {
    let font: UIFont // 입력받은 폰트
    let lineHeight: CGFloat // Text 의 전체 높이 (Full Height)

    func body(content: Content) -> some View {
        content
            .font(Font(font))
            .lineSpacing(lineHeight - font.lineHeight)
            .padding(.vertical, (lineHeight - font.lineHeight) / 2)
    }
}
