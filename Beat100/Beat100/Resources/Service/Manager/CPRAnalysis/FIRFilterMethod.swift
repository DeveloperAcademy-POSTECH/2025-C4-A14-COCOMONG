//
//  FIRFilterMethod.swift
//  Beat100
//
//  Created by 이현주 on 7/27/25.
//

import Foundation
import SwiftUI

struct FIRFilterMethod {
    // MARK: - Bandpass FIR Filter 설계 (Hamming 윈도우 적용)
    static func makeBandpassFIRCoefficients(order: Int, sampleRate: Double, lowCut: Double, highCut: Double) -> [Double] { //order: 필터 차수, sampleRate: 샘플링 주파수, lowCut, highCut: 필터의 통과 대역.
        let M = order
        let fc1 = lowCut / (sampleRate / 2) // 나이퀴스트 정리를 따라 컷오프 주파수를 정규화함 (0.0 ~ 1.0 범위).
        let fc2 = highCut / (sampleRate / 2)
        var h = [Double](repeating: 0.0, count: M + 1) // 필터 계수를 담을 배열 h를 초기화.

        for n in 0...M {
            let k = Double(n - M / 2) // 필터 중앙을 기준으로 좌우 대칭 커널을 만들기 위한 인덱스 k.
            if k == 0 { // 중심점에서는 특이점 방지를 위해 수식의 극한값을 사용.
                h[n] = fc2 - fc1
            } else { // 이상적인 밴드패스 필터의 sinc 함수 기반 공식.
                h[n] = (sin(.pi * fc2 * k) - sin(.pi * fc1 * k)) / (.pi * k)
            }
            h[n] *= 0.54 - 0.46 * cos(2.0 * .pi * Double(n) / Double(M)) // Hamming window -> Gibbs 현상 줄이기
        }

        return h
    }

    // MARK: - FIR Filter 적용
    static func applyFIRFilter(signal: [Double], coefficients: [Double]) -> [Double] { // 입력 신호(signal)에 FIR 필터 계수(coefficients)를 적용해서 필터링된 신호를 반환
        let N = coefficients.count // 필터의 계수 개수(탭 수)를 저장.
        var result = [Double](repeating: 0.0, count: signal.count) // 필터링된 결과를 담을 배열 초기화.
        var buffer = [Double](repeating: 0.0, count: N) // 입력 데이터를 저장할 이동 버퍼. 최신 신호가 맨 앞에 위치하도록 동작.

        for i in 0..<signal.count { // 전체 입력 신호 반복
            buffer.insert(signal[i], at: 0) // 새 데이터를 버퍼 맨 앞에 넣고 가장 오래된 값을 제거. 슬라이딩 윈도우처럼 작동.
            buffer.removeLast()
            result[i] = zip(buffer, coefficients).map(*).reduce(0.0, +) // 버퍼와 계수를 곱해서 누적합. 즉, 컨볼루션을 계산.
        }
        return result
    }

    // MARK: - 누적 적분 (Trapezoidal Rule 적용)
    static func integrate(signal: [Double], dt: Double) -> [Double] { // 이산 신호를 시간 간격(dt)를 기준으로 적분
        var result = [Double](repeating: 0.0, count: signal.count) // 적분 결과 배열 초기화.
        for i in 1..<signal.count { // i와 i-1 간 구간에서의 평균값을 이용하여 적분값 누적.
            result[i] = result[i - 1] + 0.5 * (signal[i] + signal[i - 1]) * dt
        }
        return result // 적분된 시계열 반환
    }

    // MARK: - 동적 기준선 추정
    static func estimateDynamicBaseline(from displacement: [Double], windowSize: Int = 11, threshold: Double = 0.0015) -> Double { // 입력은 변위 배열, windowSize: 이동 평균 윈도우 크기 (기본 30개 샘플), threshold: 정지로 간주할 수 있는 최대 진폭 범위
        // 1. 먼저 시작 부분 1초를 시도
            let preSample = displacement.prefix(50) // 샘플레이트 50Hz 기준
            let range = (preSample.max() ?? 0) - (preSample.min() ?? 0)
            if range < threshold {
                return preSample.reduce(0, +) / Double(preSample.count)
            }
        
        for i in 0..<(displacement.count - windowSize) { // windowSize 만큼의 슬라이딩 윈도우로 루프.
            let window = displacement[i..<(i + windowSize)] // 현재 위치에서 윈도우 크기만큼 슬라이스.
            let maxVar = window.max() ?? 0 // 해당 구간에서 최대/최소 값 계산.
            let minVar = window.min() ?? 0
            if (maxVar - minVar) < threshold { // 진폭이 매우 작으면(거의 정지 상태), 해당 구간의 평균값을 기준선으로 간주하여 반환.
                return window.reduce(0.0, +) / Double(window.count)
            }
        }
        return displacement.prefix(60).reduce(0.0, +) / 60.0 // 아무 기준선도 못 찾으면 처음 60개 샘플의 평균으로 fallback.
    }
}
