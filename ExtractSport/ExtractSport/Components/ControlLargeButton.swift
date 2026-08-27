//
//  ControlLargeButton.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class ControlLargeButton: UIButton {

    var currentState: ExerciseModel.CurrentState = .begin {
        didSet {
            updateUI()
        }
    }

    init() {
        super.init(frame: .zero)
        titleLabel?.font = .systemFont(ofSize: 14)
        setTitleColor(UIColor(named: "Buttons/text"), for: .normal)
        layer.cornerRadius = 10
        updateUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func updateUI() {
        switch currentState {
        case .running:
            setTitle("controlButton.stop".localized, for: .normal)
            backgroundColor = UIColor(named: "Buttons/unactive")
            isUserInteractionEnabled = true
        case .begin:
            setTitle("controlButton.start".localized, for: .normal)
            backgroundColor = UIColor(named: "Buttons/active")
            isUserInteractionEnabled = true
        case .ended:
            setTitle("controlButton.finished".localized, for: .normal)
            backgroundColor = UIColor(named: "Buttons/unactive")
            isUserInteractionEnabled = false
        case .stoped:
            setTitle("controlButton.start".localized, for: .normal)
            backgroundColor = UIColor(named: "Buttons/active")
            isUserInteractionEnabled = true
        }
    }
}
