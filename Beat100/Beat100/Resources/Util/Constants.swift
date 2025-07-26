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
    //MARK: - GuideHome
    struct GuideCard {
        struct Measurement {
            static let title = "Apple Watch에서 CPR 측정을 \n시작해보세요."
            static let content = "Apple Watch로 손목의 움직임을 감지해 가슴 압박 깊이와 속도를 측정합니다. 이후 CPR 리포트를 제공합니다."
            static let button = "시작하기"
            static let cardHeight: CGFloat = 186
        }

        struct CPR {
            static let title = "CPR 전체 가이드라인"
            static let content = "119 신고부터 가슴 압박 방법까지, \nCPR 전체 수행 과정을 알아봅니다."
            static let button = "확인하기"
            static let cardHeight: CGFloat = 156
        }
    }
    
    //MARK: - MeasurementGuide
    struct AppMechanismGuideText {
        static let title = "BEAT100 앱 작동 방식"
        static let body = """
        BEAT100은 Apple Watch의 모션 센서를 
        활용하여 CPR 중 손목의 움직임을 감지합니다. 
        압박 리듬, 속도, 깊이를 실시간으로 측정하여 
        올바른 압박을 유지할 수 있도록 돕습니다.
        """
        static let disclaimer = """
        * BEAT100 앱은 교육 목적의 시뮬레이션 도구입니다.
        실제 위급 상황에서는 사용할 수 없습니다.
        """
    }
    
    struct CompressionPositionGuideText {
        static let title = "가슴 압박 위치"
        static let body = """
            가슴 압박은 가슴뼈(흉골)의 아래쪽 1/2 지점,
            즉 양쪽 유두를 이은 선 중앙에 손바닥을 놓고
            실시합니다. 손바닥 뒤꿈치를 이용해 팔꿈치를
            곧게 편 상태로 수직으로 눌러주세요.
            """
    }
    
    struct MeasurementStartText {
        static let title = "CPR 측정하기"
        static let startButtonText = "CPR 측정 시작하기"
        
        static let step1: AttributedString = {
            var text = AttributedString("\"CPR 측정 시작하기\"를 누르면 Apple Watch앱과 연동을 시작합니다.")
            if let range = text.range(of: "\"CPR 측정 시작하기\"") {
                text[range].font = .system(.body, weight: .bold)
            }
            return text
        }()
        static let step2: AttributedString = {
            var text = AttributedString("Apple Watch 앱에서 \"확인\" 버튼을 누르면, iPhone과 Watch가 자동으로 연동돼 압박 리듬 가이드를 함께 제공합니다.")
            if let range = text.range(of: "\"확인\" 버튼") {
                text[range].font = .system(.body, weight: .bold)
            }
            return text
        }()
        static let step3 = "iPhone은 애니 근처 잘 보이는 곳에 두십시오."
    }
    
    struct RateAndDepthGuideText {
        static let title = "압박 속도와 깊이"
        
        static let step1: AttributedString = {
            var text = AttributedString("가슴 압박 속도는 분당 100-120회(bpm)을\n권장합니다.")
            
            if let range = text.range(of: "분당 100-120회(bpm)") {
                text[range].font = .system(.body, weight: .bold)
            }
            return text
        }()
        
        static let step2: AttributedString = {
            var text = AttributedString("BEAT100은 110bpm에 맞춰 Apple Watch 진동으로 압박 리듬을 제공합니다.")
            
            if let range110 = text.range(of: "110bpm") {
                text[range110].font = .system(.body, weight: .bold)
            }
            if let rangeWatch = text.range(of: "Apple Watch 진동") {
                text[rangeWatch].font = .system(.body, weight: .bold)
            }
            return text
        }()
        
        static let step3: AttributedString = {
            var text = AttributedString("깊이는 약 5~6cm를 유지하며 진동에 맞는 \n일정한 속도로 압박해주세요.")
            
            if let range = text.range(of: "5~6cm") {
                text[range].font = .system(.body, weight: .bold)
            }
            return text
        }()
        
        static let step4 = "매 압박과 이완은 1:1이 되도록 해주세요. \n이완 시 가슴이 완전히 올라오도록 이완합니다."
    }
    
    struct WatchWearingGuideText {
        static let title = "Apple Watch 착용 가이드"
        
        static let step1 = "Apple Watch를 편한 손목의 손목뼈(요골) \n위쪽에 단단히 착용해주세요."
        static let step2 = "손목 센서와 피부가 밀착되어야 올바른 압박 \n속도·깊이·리듬을 정확하게 감지할 수 있습니다."
    }
    
    //MARK: - CPRGuide
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
