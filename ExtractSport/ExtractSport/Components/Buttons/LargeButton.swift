//
//  LargeButton.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class LargeButton: UIButton {

    var isActive: Bool {
        didSet {
            updateUI()
        }
    }
    
    init(title: String, isActive: Bool) {
        self.isActive = isActive
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        backgroundColor = UIColor(named: AppConstants.Colors.buttonNext)
        setTitleColor(UIColor(named: AppConstants.Colors.buttonText), for: .normal)
        layer.cornerRadius = AppConstants.Layout.buttonCornerRadius
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func updateUI() {
        if isActive {
            backgroundColor = UIColor(named: AppConstants.Colors.buttonNext)
            isUserInteractionEnabled = true
        } else {
            backgroundColor = UIColor(named: AppConstants.Colors.buttonUnactive)
            isUserInteractionEnabled = false
        }
    }
}
