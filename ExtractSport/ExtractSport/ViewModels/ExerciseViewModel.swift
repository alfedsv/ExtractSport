//
//  ExerciseViewModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

protocol ExerciseViewModelProtocol: AnyObject {
    
    var exerciseNumber: Int { get }
    var exercisesCount: Int { get }
    var exerciseModel: ExerciseModel { get }
    var onUpdate: (() -> Void)? { get set }
    var onStarted: (() -> Void)? { get set }
    var onStoped: (() -> Void)? { get set }
    var onEnded: (() -> Void)? { get set }
    var onNext: ((WorkoutModel) -> Void)? { get set }
    func control()
    func next()
}

final class ExerciseViewModel: ExerciseViewModelProtocol {

    var exerciseNumber: Int
    var exercisesCount: Int
    var exerciseModel: ExerciseModel
    var onUpdate: (() -> Void)?
    var onStarted: (() -> Void)?
    var onStoped: (() -> Void)?
    var onEnded: (() -> Void)?
    var onNext: ((WorkoutModel) -> Void)?
    private var exerciseIndex: Int
    private let workoutModel: WorkoutModel
    private var timer: Timer?
    
    init(workoutModel: WorkoutModel) {
        self.workoutModel = workoutModel
        self.exerciseIndex = 0
        self.exerciseModel = workoutModel.exerciseModels[exerciseIndex]
        self.exerciseNumber = exerciseIndex + 1
        self.exercisesCount = workoutModel.exerciseModels.count
    }
    
    deinit {
        switch exerciseModel.currentState {
        case .running:
            exerciseModel.currentState = .stoped
            stopTimer()
            onStoped?()
        case .begin, .ended, .stoped:
            break
        }
        stopTimer()
    }
    
    private func startTimer() {
        self.onUpdate?()
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.exerciseModel.progress >= self.exerciseModel.exerciseDuration {
                self.stopTimer()
                self.exerciseModel.currentState = .ended
                self.exerciseModel.progress = self.exerciseModel.exerciseDuration
                self.onUpdate?()
                return
            }
            self.exerciseModel.progress = Int(Double(self.exerciseModel.progress) + 1.0)
            self.onUpdate?()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func control() {
        switch exerciseModel.currentState {
        case .running:
            exerciseModel.currentState = .stoped
            stopTimer()
            onStoped?()
        case .begin:
            exerciseModel.currentState = .running
            startTimer()
            onStarted?()
        case .ended:
            break
        case .stoped:
            exerciseModel.currentState = .running
            startTimer()
            onStarted?()
        }
    }

    func next() {
        
    }
    
    
}
