//
//  ExerciseModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

final class ExerciseModel {

    enum CurrentState {
        case running    // в ходе выполнения
        case begin      // в начале
        case ended      // закончено
        case stoped     // приостановлено
    }

    let id: UUID
    let title: String
    let description: String
    let imageData: Data?
    var currentState: CurrentState = .begin
    let setDuration: Int        // длительность одного подхода (сек)
    let recoveryDuration: Int   // отдых после подхода (сек)
    let setsCount: Int          // количество подходов
    let isCircuit: Bool         // является ли циклической и нужно ли добавить отдых
    let exerciseDuration: Int   // время выполнения всего уражнения
    var progress: Int = 0

    init(id: UUID, title: String, description: String, imageData: Data?, setDuration: Int, recoveryDuration: Int, setsCount: Int, isCircuit: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.imageData = imageData
        self.setDuration = setDuration
        self.recoveryDuration = recoveryDuration
        self.setsCount = setsCount
        self.isCircuit = isCircuit
        self.exerciseDuration = (setDuration + recoveryDuration) * setsCount + (isCircuit ? recoveryDuration : 0)
    }

    func setAsDone() {
        
    }
}
