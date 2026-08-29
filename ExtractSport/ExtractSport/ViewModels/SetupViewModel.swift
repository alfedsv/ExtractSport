//
//  SetupViewModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

protocol SetupViewModelProtocol: AnyObject {

    var workoutDurationMinutes: Int { get }
    var exercisesCount: Int { get }
    var onUpdate: (() -> Void)? { get set }
    var onNext: ((WorkoutModel) -> Void)? { get set }
    func workoutDurationUpdate(minuts: Int)
    func exercisesCountUpdate(count: Int)
    func next()
}

final class SetupViewModel: SetupViewModelProtocol {
    
    private(set) var workoutDurationMinutes: Int
    private(set) var exercisesCount: Int
    private let targetArea: TargetArea
    private let workoutType: WorkoutType
    private let equipment: Equipment

    var onUpdate: (() -> Void)?
    var onNext: ((WorkoutModel) -> Void)?
    
    init(targetArea: TargetArea, workoutType: WorkoutType, equipment: Equipment) {
        self.targetArea = targetArea
        self.workoutType = workoutType
        self.equipment = equipment
        self.workoutDurationMinutes = WorkoutModelConstants.workoutDurationDefault
        self.exercisesCount = WorkoutModelConstants.exercisesCountDefault
    }
    
    func workoutDurationUpdate(minuts: Int) {
        self.workoutDurationMinutes = minuts
        self.onUpdate?()
    }

    func exercisesCountUpdate(count: Int) {
        self.exercisesCount = count
        self.onUpdate?()
    }

    func next() {
        if exercisesCount > 0 {
            let workoutModel = WorkoutModel(
                targetArea: targetArea,
                workoutType: workoutType,
                equipment: equipment,
                workoutDuration: workoutDurationMinutes * 60,
                exercisesCount: exercisesCount
            )
            onNext?(workoutModel)
        }
    }
}
