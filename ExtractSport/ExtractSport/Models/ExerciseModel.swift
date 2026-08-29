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
    let index: Int
    let title: String
    let description: String
    let imageData: Data?
    var currentState: CurrentState = .begin
    let setDuration: Int        // длительность одного подхода (сек)
    let recoveryDuration: Int   // отдых после подхода (сек)
    let setsCount: Int          // количество подходов
    let isLastInCycle: Bool     // является ли циклической и нужно ли добавить отдых
    let exerciseDuration: Int   // время выполнения всего уражнения
    var progress: Int = 0

    init(id: UUID, index: Int, title: String, description: String, imageData: Data?, setDuration: Int, recoveryDuration: Int, setsCount: Int, isLastInCycle: Bool) {
        self.id = id
        self.index = index
        self.title = title
        self.description = description
        self.imageData = imageData
        self.setDuration = setDuration
        self.recoveryDuration = recoveryDuration
        self.setsCount = setsCount
        self.isLastInCycle = isLastInCycle
        self.exerciseDuration = (setDuration + recoveryDuration) * setsCount + (isLastInCycle ? recoveryDuration : 0)
    }

}
