//
//  LargeButton.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class LargeButton: UIButton {

    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        backgroundColor = UIColor(named: "Buttons/next")
        setTitleColor(UIColor(named: "Buttons/text"), for: .normal)
        layer.cornerRadius = 10
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
