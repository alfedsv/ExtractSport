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
    
    var workoutDuration: Int
    var exercisesCount: Int
    var currentExerciseIndex: Int = 0

    var warmUpModels: [WarmUpCoolDownModel] = []
    var exerciseModels: [ExerciseModel] = []
    var coolDownModels: [WarmUpCoolDownModel] = []

    init(targetArea: TargetArea, workoutType: WorkoutType, equipment: Equipment, workoutDuration: Int, exercisesCount: Int) {
        self.targetArea = targetArea
        self.workoutType = workoutType
        self.equipment = equipment
        self.workoutDuration = workoutDuration
        self.exercisesCount = exercisesCount
        let workoutHelper = WorkoutHelper(totalDuration: workoutDuration, userExercisesCount: exercisesCount, workoutType: workoutType)
        warmUpModels = workoutHelper.getWarmUpExercises(targetArea: targetArea)
        coolDownModels = workoutHelper.getCoolDownExercises(targetArea: targetArea)
        exerciseModels = workoutHelper.getWorkoutExercises(targetArea: targetArea, workoutType: workoutType, equipment: equipment)
    }
}
