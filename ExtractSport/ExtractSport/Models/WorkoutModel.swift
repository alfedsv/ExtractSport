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

    var warmUpModels: [WarmUpCoolDownModel] = []
    var exerciseModels: [ExerciseModel] = []
    var coolDownModels: [WarmUpCoolDownModel] = []
    
    var workoutDuration: Int
    var exerciseCount: Int
    
    init(targetArea: TargetArea, workoutType: WorkoutType, equipment: Equipment) {
        self.targetArea = targetArea
        self.workoutType = workoutType
        self.equipment = equipment
        
        self.workoutDuration = WorkoutModelConstants.workoutDurationDefault
        self.exerciseCount = WorkoutModelConstants.exerciseCountDefault
        
        warmUpModels = generateRandomModels(count: WorkoutModelConstants.warmUpExerciseCount, duration: WorkoutModelConstants.warmUpDuration)
        coolDownModels = generateRandomModels(count: WorkoutModelConstants.coolDownExerciseCount, duration: WorkoutModelConstants.coolDownDuration)
        
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
                progress: 0,
                duration: duration,
                currentState: .begin
            )
            models.append(model)
        }
        return models
    }
}
