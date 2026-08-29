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
        
        warmUpModels = generateRandomModels(count: WorkoutModelConstants.warmUpExercisesCount, duration: WorkoutModelConstants.warmUpDuration)
        coolDownModels = generateRandomModels(count: WorkoutModelConstants.coolDownExercisesCount, duration: WorkoutModelConstants.coolDownDuration)
        let workoutHelper = WorkoutHelper(totalDuration: workoutDuration, userExercisesCount: exercisesCount, workoutType: workoutType)
        exerciseModels = generateRandomModels(exercisePlanModels: workoutHelper.exercisePlans)
    }
    
    func generateRandomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
        var result = ""
        for i in 0..<length {
            // Примерно в 20% случаев вставляем пробел (кроме первого символа)
            if i > 0 && Int.random(in: 0...10) < 2 {
                result += " "
            } else {
                let randomIndex = Int.random(in: 0..<letters.count)
                let char = letters[letters.index(letters.startIndex, offsetBy: randomIndex)]
                result += String(char)
            }
        }
        return result
    }

    func generateRandomModels(count: Int, duration: Int) -> [WarmUpCoolDownModel] {
        var models: [WarmUpCoolDownModel] = []
        for _ in 0..<count {
            let titleLength = Int.random(in: 3...12)
            let descriptionLength = Int.random(in: 20...220)
            
            let model = WarmUpCoolDownModel(
                id: UUID(),
                imageData: nil,
                title: generateRandomString(length: titleLength),
                description: generateRandomString(length: descriptionLength),
                duration: duration
            )
            models.append(model)
        }
        return models
    }
    
    func generateRandomModels(exercisePlanModels: [WorkoutHelper.ExercisePlanModel]) -> [ExerciseModel] {
        var models: [ExerciseModel] = []
        for (index, exercisePlanModel) in exercisePlanModels.enumerated() {
            let titleLength = Int.random(in: 3...12)
            let descriptionLength = Int.random(in: 20...220)
            let model = ExerciseModel(
                id: UUID(),
                index: index,
                title: generateRandomString(length: titleLength),
                description: generateRandomString(length: descriptionLength),
                imageData: nil,
                setDuration: exercisePlanModel.setDuration,
                recoveryDuration: exercisePlanModel.recoveryDuration,
                setsCount: exercisePlanModel.setsCount,
                isCircuit: workoutType == .circuit
            )
            models.append(model)
        }
        return models
    }
}
