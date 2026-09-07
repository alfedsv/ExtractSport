//
//  WorkoutHelper.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 26.08.2026.
//

import Foundation

final class WorkoutHelper {
    
    struct ExercisePlanModel {
        let setDuration: Int            // длительность одного подхода (сек)
        let recoveryDuration: Int       // отдых после подхода (сек)
        let setsCount: Int              // количество подходов
        let isLastInCycle: Bool         // если последнее упраженеие в круге
    }
    
    private let warmUpDuration: Int = 4 * 60      // 4 мин
    private let coolDownDuration: Int = 3 * 60    // 3 мин

    let totalDuration: Int          // общая длительность тренировки (сек)
    let userExercisesCount: Int     // количество упражнений, выбранное пользователем
    let workoutType: WorkoutType    // тип тренировки
    
    var mainWorkoutTime: Int {
        return totalDuration - warmUpDuration - coolDownDuration
    }
    
    var restBetweenSets: Int {
        switch workoutType {
        case .strength: return 60
        case .endurance: return 30
        case .explosivePower: return 90
        case .circuit: return 15
        }
    }
    
    var restBetweenCycles: Int {
        return workoutType == .circuit ? 60 : 0
    }
    
    let cyclesCount: Int
    
    var totalExercisesCount: Int {
        return userExercisesCount * cyclesCount
    }
    
    var timePerExercise: Int {
        // (mainWorkoutTime - отдых между кругами) / общее количество упражнений
        let available = mainWorkoutTime - ((cyclesCount - 1) * restBetweenCycles)
        return available / totalExercisesCount   // целочисленное деление (округление вниз)
    }
    
    var exercisePlans: [ExercisePlanModel] {
        var plan: [ExercisePlanModel] = []
        print("Создан план тренировки (\(workoutType)):")
        print("Зона проработки: \(workoutType)")
        print("Количество упраженений:\t\(totalExercisesCount)")
        print("Количество кругов:\t\(cyclesCount)")
        print("Время на всю тренировку:\t\(totalDuration)")
        for cycle in 0..<cyclesCount {
            print("Круг (index):\t\(cycle)")
            for exerciseIndex in 0..<userExercisesCount {
                print("Упражнение (index):\t\(exerciseIndex)")
                let setDuration = randomSetDuration(workoutType: workoutType)   // длительность подхода
                let recoveryDuration = recoveryDuration(workoutType: workoutType, setDuration: setDuration)
                let setsCount = timePerExercise / (setDuration + recoveryDuration)
                let isLast = (exerciseIndex % userExercisesCount == userExercisesCount - 1)
                print("\tКоличество походов:\t\(setsCount)")
                print("\tВремя на все упраженение:\t\(timePerExercise)")
                print("\tВремя на один подход:\t\(setDuration)")
                print("\tВремя на одых после подхода:\t\(recoveryDuration)")
                plan.append(ExercisePlanModel(setDuration: setDuration, recoveryDuration: recoveryDuration, setsCount: setsCount, isLastInCycle: isLast))
            }
        }
        return plan
    }

    init(totalDuration: Int, userExercisesCount: Int, workoutType: WorkoutType) {
        self.totalDuration = totalDuration
        self.userExercisesCount = userExercisesCount
        self.workoutType = workoutType
        if workoutType == .circuit {
            self.cyclesCount = Int.randomTriangular(min: 1, max: 7, mode: 4)
        } else {
            self.cyclesCount = 1
        }
    }

    func getWarmUpExercises(targetArea: TargetArea) -> [WarmUpCoolDownModel] {
        let dataSource: WarmUp = WarmUp()
        let exs: [WarmUp.Exercise] = dataSource.getExercises(targetArea: targetArea)
        let exercises = exs.shuffled().prefix(WorkoutModelConstants.warmUpExercisesCount).map { $0 }
        var models: [WarmUpCoolDownModel] = []
        for exercise in exercises {
            let model = WarmUpCoolDownModel(
                id: exercise.id,
                imageName: exercise.image,
                title: exercise.name,
                description: exercise.description,
                duration: WorkoutModelConstants.warmUpDuration
            )
            models.append(model)
        }
        return models
    }

    func getCoolDownExercises(targetArea: TargetArea) -> [WarmUpCoolDownModel] {
        let dataSource: CoolDown = CoolDown()
        let exs: [CoolDown.Exercise] = dataSource.getExercises(targetArea: targetArea)
        let exercises = exs.shuffled().prefix(WorkoutModelConstants.coolDownExercisesCount).map { $0 }
        var models: [WarmUpCoolDownModel] = []
        for exercise in exercises {
            let model = WarmUpCoolDownModel(
                id: exercise.id,
                imageName: exercise.image,
                title: exercise.name,
                description: exercise.description,
                duration: WorkoutModelConstants.coolDownDuration
            )
            models.append(model)
        }
        return models
    }

    func getWorkoutExercises(targetArea: TargetArea, workoutType: WorkoutType, equipment: Equipment) -> [ExerciseModel] {
        let dataSource: Workout = Workout()
        let exs: [Workout.Exercise] = dataSource.getExercises(targetArea: targetArea, workoutType: workoutType, equipment: equipment)
        guard exs.count >= userExercisesCount else {
            print("[ERROR] Недостаточно упражнений в базе для выбранного количества")
            return []
        }
        let baseExercises = exs.shuffled().prefix(userExercisesCount).map { $0 }
        let exercises = Array(repeating: baseExercises, count: cyclesCount).flatMap { $0 }
        guard exercises.count == exercisePlans.count else {
            print("[ERROR] exercises.count (\(exercises.count)) != exercisePlans.count (\(exercisePlans.count))")
            return []
        }
        var models: [ExerciseModel] = []
        for (index, exercisePlanModel) in exercisePlans.enumerated() {
            let model = ExerciseModel(
                id: exercises[index].id,
                index: index,
                title: exercises[index].name,
                description: exercises[index].description,
                imageName: exercises[index].image,
                setDuration: exercisePlanModel.setDuration,
                recoveryDuration: exercisePlanModel.recoveryDuration,
                setsCount: exercisePlanModel.setsCount,
                isLastInCycle: workoutType == .circuit && exercisePlanModel.isLastInCycle
            )
            models.append(model)
        }
        return models
    }
    
    func getWorkoutExercisesCount(targetArea: TargetArea, workoutType: WorkoutType, equipment: Equipment) -> Int {
        let dataSource: Workout = Workout()
        let exs: [Workout.Exercise] = dataSource.getExercises(targetArea: targetArea, workoutType: workoutType, equipment: equipment)
        return exs.count
    }

    // Генерация длительности подхода (кратно 5)
    private func randomSetDuration(workoutType: WorkoutType) -> Int {
        let range: ClosedRange<Int>
        switch workoutType {
        case .strength: range = 45...90
        case .endurance: range = 60...120
        case .explosivePower: range = 15...30
        case .circuit: range = 40...60
        }
        let raw = Int.random(in: range)
        return (raw / 5) * 5   // округление вниз до кратного 5
    }
    
    // Время восстановления после подхода
    private func recoveryDuration(workoutType: WorkoutType, setDuration: Int) -> Int {
        switch workoutType {
        case .strength: return setDuration
        case .endurance: return setDuration / 2
        case .explosivePower: return setDuration * 2
        case .circuit: return setDuration / 3
        }
    }
    
}
