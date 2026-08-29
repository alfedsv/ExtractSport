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
    
    var cyclesCount: Int {
        guard workoutType == .circuit else { return 1 }
        // Треугольное распределение: мин=1, макс=7, медиана=4
        return Int.randomTriangular(min: 1, max: 7, mode: 4)
    }
    
    var totalExercisesCount: Int {
        return userExercisesCount * cyclesCount
    }
    
    var timePerExercise: Int {
        // (mainWorkoutTime - отдых между кругами) / общее количество упражнений
        let available = mainWorkoutTime - (cyclesCount * restBetweenCycles)
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
            for exerciseIndex in 0..<totalExercisesCount {
                print("Упражнение (index):\t\(exerciseIndex)")
                let setDuration = randomSetDuration(workoutType: workoutType)   // длительность подхода
                let recoveryDuration = recoveryDuration(workoutType: workoutType, setDuration: setDuration)
                let setsCount = timePerExercise / (setDuration + recoveryDuration)
                let isLast = (exerciseIndex == userExercisesCount - 1)
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
