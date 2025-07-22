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
                return "NanumSquareNeoTTF-aLt"
            case .regular:
                return "NanumSquareNeoTTF-bRg"
            case .bold:
                return "NanumSquareNeoTTF-cBd"
            case .extrabold:
                return "NanumSquareNeoTTF-dEb"
            case .heavy:
                return "NanumSquareNeoTTF-eHv"
            }
        }
    }
    
    static func nanumSquareNeo(type: NanumSquareNeo, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
