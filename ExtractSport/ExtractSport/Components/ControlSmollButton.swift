//
//  ControlSmollButton.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class ControlSmollButton: UIButton {

    var currentState: WarmUpCoolDownModel.CurrentState = .running {
        didSet {
            updateUI()
        }
    }
    
    var isLocked: Bool = false {
        didSet {
            updateUI()
        }
    }

    init() {
        super.init(frame: .zero)
        titleLabel?.font = .systemFont(ofSize: 14)
        layer.cornerRadius = 10
    }
    
    private func updateUI() {
        if isLocked {
            backgroundColor = UIColor(named: "Buttons/unactive")
            isUserInteractionEnabled = false
            isHidden = false
        } else {
            switch currentState {
            case .running:
                backgroundColor = .clear
                isUserInteractionEnabled = false
                isHidden = true
            case .begin:
                setTitle("controlButton.start".localized, for: .normal)
                backgroundColor = UIColor(named: "Buttons/active")
                isUserInteractionEnabled = true
                isHidden = false
            case .ended:
                setTitle("controlButton.onceMore".localized, for: .normal)
                backgroundColor = UIColor(named: "Buttons/onceMore")
                isUserInteractionEnabled = true
                isHidden = false
            }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
