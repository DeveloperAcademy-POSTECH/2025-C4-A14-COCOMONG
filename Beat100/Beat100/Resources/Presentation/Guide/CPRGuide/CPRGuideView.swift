//
//  CPRGuideView.swift
//  Beat100
//
//  Created by oliver on 7/23/25.
//

import SwiftUI

struct CPRGuideView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            CustomNavigationBar(title: {
                Text("CPR 전체 가이드라인")
            })
            Content()
        }
        .background(.gray200)
    }
}

private struct Content: View {
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                Step(
                    imageResource: .guide1,
                    title: "1단계 : 환자의 반응과 호흡 확인",
                    description: "의식이 없는 환자를 발견하면, 먼저 어깨를 두드리고 “괜찮으세요?”라고 큰 소리로 반응을 확인합니다.\n10초 이내로 관찰하며 정상 호흡 여부를 확인합니다."
                )
                Step(
                    imageResource: .guide2,
                    title: "2단계 : 신속한 도움 요청 및 119 신고",
                    description: "주위 특정인을 지목해 119 신고와 자동심장충격기(AED) 요청을 부탁합니다. 혼자라면 즉시 119에 신고 후 CPR을 시작합니다."
                )
                Step(
                    imageResource: .guide3,
                    title: "3단계 : 가슴압박 시작",
                    description: "환자의 가슴 중앙(흉골 하단 1/2)에 두 손을 포개 얹고,\n팔을 곧게 펴 체중을 실어, 분당 100~120회 속도와 5~6cm 깊이로 압박합니다."
                )
                Step(
                    imageResource: .guide4,
                    title: "4단계 : 기도 개방 및 인공호흡",
                    description: "가슴압박 30회 시행 후 인공호흡을 위해 머리를 젖히고 턱을 들어 올려 기도 개방을 시도합니다. 인공호흡이 \n어려운 경우, 가슴압박만 지속해도 무방합니다."
                )
                Step(
                    imageResource: .guide5,
                    title: "5단계 : 가슴압박과 인공호흡 반복",
                    description: "30회의 가슴압박과 2회 인공호흡을 반복합니다. \n구급대원이 현장에 도착하거나 환자가 스스로 \n움직이기 시작할 때까지 이 과정을 반복합니다."
                )
            }
            .padding(.top, 40)
            .padding(.bottom, 102)
        }
        .frame(width: 353, alignment: .topLeading)
    }
}

private struct Step: View {
    var imageResource: ImageResource
    var title: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(imageResource)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 353, height: 210)
                .clipped()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 15))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text(description)
                    .font(.system(size: 15))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
    }
}

#Preview {
    CPRGuideView()
}
