//
//  Font+Extensions.swift
//  WatchBeat100 Watch App
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
    
    enum SFCompact {
        case light
        case regular
        case medium
        case semibold
        case bold
        case heavy
        
        var value: String {
            switch self {
            case .light:
                return "SFCompactText-Light"
            case .regular:
                return "SFCompactText-Regular"
            case .medium:
                return "SFCompactText-Medium"
            case .semibold:
                return "SFCompactText-Semibold"
            case .bold:
                return "SFCompactText-Bold"
            case .heavy:
                return "SFCompactText-Heavy"
            }
        }
    }
    
    static func nanumSquareNeo(type: NanumSquareNeo, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    static func sfCompact(type: SFCompact, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
