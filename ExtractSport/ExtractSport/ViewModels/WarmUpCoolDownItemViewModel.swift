//
//  WarmUpCoolDownItemViewModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 26.08.2026.
//

import Foundation

protocol WarmUpCoolDownItemViewModelInternalProtocol {
    var onExerciseBegins: ((UUID) -> Void)? { get set }
    var onExerciseEnded: ((UUID) -> Void)? { get set }
    func locked()
    func unlocked()
    func setAsDone()
}

protocol WarmUpCoolDownItemViewModelProtocol {
    var model: WarmUpCoolDownModel { get }
    var onUpdate: (() -> Void)? { get set }
    var onLockOrUnlock: ((Bool) -> Void)? { get set }
    func signal()
}

final class WarmUpCoolDownItemViewModel: WarmUpCoolDownItemViewModelInternalProtocol, WarmUpCoolDownItemViewModelProtocol {
    
    var model: WarmUpCoolDownModel
    var onUpdate: (() -> Void)?
    var onLockOrUnlock: ((Bool) -> Void)?

    var onExerciseBegins: ((UUID) -> Void)?
    var onExerciseEnded: ((UUID) -> Void)?

    private var timer: Timer?
    
    init(model: WarmUpCoolDownModel) {
        self.model = model
    }
    
    deinit {
        stopTimer()
    }
    
    func signal() {
        switch model.currentState {
        case .running:
            break
        case .begin:
            onExerciseBegins?(self.model.id)
            model.currentState = .running
            startTimer()
        case .ended:
            onExerciseBegins?(self.model.id)
            model.progress = 0
            model.currentState = .running
            startTimer()
        }
    }
    
    func locked() {
        model.isLocked = true
        self.onLockOrUnlock?(true)
    }
    
    func unlocked() {
        model.isLocked = false
        self.onLockOrUnlock?(false)
    }
    
    private func startTimer() {
        self.onUpdate?()
        guard timer == nil else { return }
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.model.progress >= model.duration {
                self.stopTimer()
                self.model.currentState = .ended
                self.model.progress = model.duration
                self.onUpdate?()
                self.onExerciseEnded?(self.model.id)
                print(self.model.progress)
                return
            }
            self.model.progress = Int(Double(self.model.progress) + 1.0)
            self.onUpdate?()
        }
    }
    
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func setAsDone() {
        stopTimer()
        model.setAsDone()
        self.onExerciseEnded?(self.model.id)
        self.onUpdate?()
    }
}
