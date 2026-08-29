//
//  WarmUpCoolDownViewModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 26.08.2026.
//

import Foundation

protocol WarmUpCoolDownViewModelProtocol: AnyObject {
    var itemViewModels: [WarmUpCoolDownItemViewModel] { get }
    var onShowWarning: ((WarmUpCoolDownViewModel.ControllerType) -> Void)? { get set }
    var onNext: ((WarmUpCoolDownViewModel.ControllerType, WorkoutModel) -> Void)? { get set }
    func tryNext()
    func next()
    func back()
}

final class WarmUpCoolDownViewModel: WarmUpCoolDownViewModelProtocol {
    
    enum ControllerType {
        case warmUp
        case coolDown
    }
    
    var itemViewModels: [WarmUpCoolDownItemViewModel] = []
    
    var onShowWarning: ((WarmUpCoolDownViewModel.ControllerType) -> Void)?
    var onNext: ((ControllerType, WorkoutModel) -> Void)?
    
    private let controllerType: ControllerType
    private let workoutModel: WorkoutModel
    
    init(controllerType: ControllerType, workoutModel: WorkoutModel) {
        self.controllerType = controllerType
        self.workoutModel = workoutModel
        switch controllerType {
        case .warmUp:
            for model in workoutModel.warmUpModels {
                let viewModel = WarmUpCoolDownItemViewModel(model: model)
                itemViewModels.append(viewModel)
            }
        case .coolDown:
            for model in workoutModel.coolDownModels {
                let viewModel = WarmUpCoolDownItemViewModel(model: model)
                itemViewModels.append(viewModel)
            }
        }
        bindViewModel()
    }
    
    private func bindViewModel() {
        for viewModel in itemViewModels {
            viewModel.onExerciseBegins = { [weak self] id in
                guard let self = self else { return }
                for itemViewModel in self.itemViewModels {
                    if itemViewModel.model.id != id {
                        itemViewModel.locked()
                    }
                }
                
            }
            viewModel.onExerciseEnded = { [weak self] id in
                guard let self = self else { return }
                for itemViewModel in self.itemViewModels {
                    if itemViewModel.model.id != id {
                        itemViewModel.unlocked()
                    }
                }
            }
        }
    }
    
    private func isAllDone() -> Bool {
        for itemViewModel in self.itemViewModels {
            if itemViewModel.model.currentState != .ended {
                return false
            }
        }
        return true
    }
    
    private func setAllAsDone() {
        for itemViewModel in self.itemViewModels {
            itemViewModel.setAsDone()
        }
    }
    
    func tryNext() {
        if isAllDone() {
            onNext?(controllerType, workoutModel)
        } else {
            onShowWarning?(controllerType)
        }
    }
    
    func next() {
        setAllAsDone()
        onNext?(controllerType, workoutModel)
    }
    
    func back() {
        if controllerType == .coolDown {
            for itemViewModel in self.itemViewModels {
                itemViewModel.model.currentState = .stoped
            }
        }
    }

}
