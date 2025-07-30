//
//  HealthKitManager.swift
//  Beat100
//
//  Created by 나현흠 on 7/30/25.
//

import HealthKit

class HealthKitManager {
    static let shared = HealthKitManager()
    let healthStore = HKHealthStore()

    private init() {}
    
    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        guard HKHealthStore.isHealthDataAvailable() else {
            completion(false)
            return
        }

        let typesToShare: Set = [HKObjectType.workoutType()]
        let typesToRead: Set = [HKObjectType.workoutType()]

        healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    print("HealthKit 권한 오류: \(error.localizedDescription)")
                }
                completion(success)
            }
        }
    }
}
