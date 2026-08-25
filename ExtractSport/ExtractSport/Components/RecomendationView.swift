//
//  RecomendationView.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class RecomendationView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "recomendationTitle")
        label.text = "recomendation.title".localized
        return label
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor(named: "labelText")
        label.numberOfLines = 3
        return label
    }()
    
    init(workoutType: WorkoutType) {
        super.init(frame: .zero)
        addSubview(titleLabel)
        addSubview(textLabel)
        backgroundColor = UIColor(named: "recomendationBackground")
        switch workoutType {
        case .strength:
            textLabel.text = "recomendation.strength".localized
        case .endurance:
            textLabel.text = "recomendation.endurance".localized
        case .explosivePower:
            textLabel.text = "recomendation.explosivePower".localized
        case .circuit:
            textLabel.text = "recomendation.circuit".localized
        }
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
extension RecomendationView {
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 7),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            
            textLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -7),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 7),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -14)
        ])
    }
}
