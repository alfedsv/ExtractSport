//
//  DescriptionLabel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 30.08.2026.
//

import UIKit

final class DescriptionLabel: UILabel {

    init() {
        super.init(frame: .zero)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        font = .systemFont(ofSize: 14)
        textColor = UIColor(named: AppConstants.Colors.labelText)
        numberOfLines = 0
    }
}
