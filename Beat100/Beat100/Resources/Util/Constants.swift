//
//  Constants.swift
//  Beat100
//
//  Created by 이현주 on 7/15/25.
//

import Foundation
import SwiftUI

// iOS, Watch OS 모두 사용
struct Constants {
    struct CPRGuideText {
        static let navTitle = "CPR 전체 가이드라인"

        struct Step1 {
            static let title = "1단계 : 환자의 반응과 호흡 확인"
            static let description = """
            의식이 없는 환자를 발견하면, 먼저 어깨를 두드리고 “괜찮으세요?”라고 큰 소리로 반응을 확인합니다.
            10초 이내로 관찰하며 정상 호흡 여부를 확인합니다.
            """
        }

        struct Step2 {
            static let title = "2단계 : 신속한 도움 요청 및 119 신고"
            static let description = """
            주위 특정인을 지목해 119 신고와 자동심장충격기(AED) 요청을 부탁합니다. 혼자라면 즉시 119에 신고 후 CPR을 시작합니다.
            """
        }

        struct Step3 {
            static let title = "3단계 : 가슴압박 시작"
            static let description = """
            환자의 가슴 중앙(흉골 하단 1/2)에 두 손을 포개 얹고,
            팔을 곧게 펴 체중을 실어, 분당 100~120회 속도와 5~6cm 깊이로 압박합니다.
            """
        }

        struct Step4 {
            static let title = "4단계 : 기도 개방 및 인공호흡"
            static let description = """
            가슴압박 30회 시행 후 인공호흡을 위해 머리를 젖히고 턱을 들어 올려 기도 개방을 시도합니다. 인공호흡이
            어려운 경우, 가슴압박만 지속해도 무방합니다.
            """
        }

        struct Step5 {
            static let title = "5단계 : 가슴압박과 인공호흡 반복"
            static let description = """
            30회의 가슴압박과 2회 인공호흡을 반복합니다.
            구급대원이 현장에 도착하거나 환자가 스스로
            움직이기 시작할 때까지 이 과정을 반복합니다.
            """
        }
    }
}
