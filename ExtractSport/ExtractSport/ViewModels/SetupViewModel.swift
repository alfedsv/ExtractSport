//
//  SetupViewModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

protocol SetupViewModelProtocol: AnyObject {

    var workoutDuration: Int { get }
    var exerciseCount: Int { get }
    var onUpdate: (() -> Void)? { get set }
    func workoutDurationUpdate(minuts: Int)
    func exerciseCountUpdate(count: Int)
    func next()
    var onNext: ((WorkoutModel) -> Void)? { get set }
}

final class SetupViewModel: SetupViewModelProtocol {
    
    var workoutDuration: Int
    var exerciseCount: Int
    var onUpdate: (() -> Void)?
    var onNext: ((WorkoutModel) -> Void)?
    
    private let workoutModel: WorkoutModel
    
    init(workoutModel: WorkoutModel) {
        self.workoutModel = workoutModel
        self.workoutDuration = workoutModel.workoutDuration
        self.exerciseCount = workoutModel.exerciseCount
    }
    
    func workoutDurationUpdate(minuts: Int) {
        self.workoutDuration = minuts
        self.workoutModel.workoutDuration = minuts
        self.onUpdate?()
    }

    func exerciseCountUpdate(count: Int) {
        self.exerciseCount = count
        self.workoutModel.exerciseCount = count
        self.onUpdate?()
    }

    func next() {
        onNext?(workoutModel)
    }
}
