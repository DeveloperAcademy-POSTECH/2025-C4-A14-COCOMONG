//
//  WorkoutManager.swift
//  Beat100
//
//  Created by 나현흠 on 7/30/25.
//

import Foundation
import HealthKit

class WorkoutManager: NSObject, ObservableObject, HKWorkoutSessionDelegate, HKLiveWorkoutBuilderDelegate {
    
    private let healthStore = HKHealthStore()
    private var session: HKWorkoutSession?
    private var builder: HKLiveWorkoutBuilder?
    
    func startWorkout() {
        let config = HKWorkoutConfiguration()
        config.activityType = .traditionalStrengthTraining // CPR은 여기에 맞는 activityType 선택
        config.locationType = .indoor
        
        do {
            session = try HKWorkoutSession(healthStore: healthStore, configuration: config)
            builder = session?.associatedWorkoutBuilder()
            
            session?.delegate = self
            builder?.dataSource = HKLiveWorkoutDataSource(healthStore: healthStore, workoutConfiguration: config)
            
            session?.startActivity(with: Date())
            builder?.beginCollection(withStart: Date()) { success, error in
                if let error = error {
                    print("Workout builder 시작 실패: \(error.localizedDescription)")
                }
            }
        } catch {
            print("Workout session 생성 실패: \(error.localizedDescription)")
        }
    }
    
    func stopWorkout() {
        session?.end()
        builder?.endCollection(withEnd: Date()) { _, _ in
            self.builder?.finishWorkout { _, _ in
                print("Workout 종료 완료")
            }
        }
    }
    
    func workoutBuilderDidCollectEvent(_ workoutBuilder: HKLiveWorkoutBuilder) {
        let events = workoutBuilder.workoutEvents
    }

    // MARK: - Delegate
    func workoutSession(_ workoutSession: HKWorkoutSession, didChangeTo toState: HKWorkoutSessionState, from fromState: HKWorkoutSessionState, date: Date) {
        print("Workout 상태 변경: \(fromState.rawValue) -> \(toState.rawValue)")
    }
    
    func workoutSession(_ workoutSession: HKWorkoutSession, didFailWithError error: Error) {
        print("Workout 에러: \(error.localizedDescription)")
    }
    
    func workoutBuilder(_ workoutBuilder: HKLiveWorkoutBuilder, didCollectDataOf collectedTypes: Set<HKSampleType>) {
        print("데이터 수집됨: \(collectedTypes)")
    }
}
