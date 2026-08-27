//
//  StartViewModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

protocol StartViewModelProtocol: AnyObject {
    var selectedTargetArea: TargetArea { get }
    var selectedWorkoutType: WorkoutType { get }
    var selectedEquipment: Equipment { get }
    func select(option: SetupProtocol)
    func next()
    var onUpdate: (() -> Void)? { get set }
    var onNext: ((TargetArea, WorkoutType, Equipment) -> Void)? { get set }
}

final class StartViewModel: StartViewModelProtocol {

    private(set) var selectedTargetArea: TargetArea
    private(set) var selectedWorkoutType: WorkoutType
    private(set) var selectedEquipment: Equipment

    var onUpdate: (() -> Void)?
    var onNext: ((TargetArea, WorkoutType, Equipment) -> Void)?

    init() {
        selectedTargetArea = TargetArea.default
        selectedWorkoutType = WorkoutType.default
        selectedEquipment = Equipment.default
    }

    func select(option: SetupProtocol) {
        switch option.setupType {
        case .targetArea:
            guard let value = option as? TargetArea else { return }
            selectedTargetArea = value
        case .workoutType:
            guard let value = option as? WorkoutType else { return }
            selectedWorkoutType = value
        case .equipment:
            guard let value = option as? Equipment else { return }
            selectedEquipment = value
        }
        onUpdate?()
    }
    
    func next() {
        onNext?(selectedTargetArea, selectedWorkoutType, selectedEquipment)
    }
}
