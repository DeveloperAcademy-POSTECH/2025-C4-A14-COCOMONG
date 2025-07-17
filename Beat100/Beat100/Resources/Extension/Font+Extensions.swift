//
//  Font+Extensions.swift
//  Beat100
//
//  Created by 이현주 on 7/15/25.
//

import Foundation
import SwiftUI

extension Font {
    enum NanumSquareNeo {
        case light
        case regular
        case bold
        case extrabold
        case heavy
        
        var value: String {
            switch self {
            case .light:
                return "NanumSquareNeo-aLt"
            case .regular:
                return "NanumSquareNeo-bRg"
            case .bold:
                return "NanumSquareNeo-cBd"
            case .extrabold:
                return "NanumSquareNeo-dEb"
            case .heavy:
                return "NanumSquareNeo-eHv"
            }
        }
    }
    
    static func nanumSquareNeo(type: NanumSquareNeo, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
