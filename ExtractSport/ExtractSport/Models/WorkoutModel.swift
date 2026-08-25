//
//  WorkoutModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

final class WorkoutModel {

    var targetArea: TargetArea
    var workoutType : WorkoutType
    var equipment: Equipment

    var warmUpModels: [WarmUpModel] = []
    var exerciseModels: [ExerciseModel] = []
    var coolDownModels: [CoolDownModel] = []
    
    var workoutDuration: Int
    var exerciseCount: Int
    
    init(targetArea: TargetArea, workoutType: WorkoutType, equipment: Equipment) {
        self.targetArea = targetArea
        self.workoutType = workoutType
        self.equipment = equipment
        
        self.workoutDuration = WorkoutModelConstants.workoutDurationDefault
        self.exerciseCount = WorkoutModelConstants.exerciseCountDefault
    }
}
