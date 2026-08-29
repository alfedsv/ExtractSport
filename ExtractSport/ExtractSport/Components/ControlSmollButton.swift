//
//  ControlSmollButton.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class ControlSmollButton: UIButton {

    var currentState: WarmUpCoolDownModel.CurrentState = .begin {
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
        setTitleColor(UIColor(named: "Buttons/text"), for: .normal)
        layer.cornerRadius = 10
        updateUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            case .stoped:
                setTitle("controlButton.start".localized, for: .normal)
                backgroundColor = UIColor(named: "Buttons/active")
                isUserInteractionEnabled = true
                isHidden = false
            }
        }
    }
}
