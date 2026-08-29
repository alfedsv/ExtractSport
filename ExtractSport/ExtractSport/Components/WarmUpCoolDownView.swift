//
//  WarmUpCoolDownView.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 26.08.2026.
//

import UIKit

final class WarmUpCoolDownView: UIView {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = UIColor(named: "iconColor")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(named: "labelText")
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: "labelText")
        label.numberOfLines = 0
        return label
    }()

    private let progressView = UIProgressView(progressViewStyle: .default)
    private let button = ControlSmollButton()
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = UIColor(named: "labelText")
        label.isHidden = true
        label.textAlignment = .center
        label.text = "MM:SS"
        return label
    }()
     
    var viewModel: WarmUpCoolDownItemViewModelProtocol
    
    init(viewModel: WarmUpCoolDownItemViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupUI()
        bindViewModel()
    }
     
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.updateProgressBar()
        }
        
        viewModel.onLockOrUnlock = { [weak self] isLocked in
            guard let self = self else { return }
            self.button.isLocked = isLocked
        }
    }

    private func setupUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 8
        layer.borderWidth = 0.5
        layer.borderColor = UIColor(named: "border")?.cgColor
        
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(progressView)
        addSubview(button)
        addSubview(timerLabel)

        titleLabel.text = viewModel.model.title
        descriptionLabel.text = viewModel.model.description
        progressView.progressTintColor = UIColor(named: "progressBar")
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.currentState = viewModel.model.currentState

        setupConstraints()
        updateProgressBar()
    }
    
    private func updateProgressBar() {
        let maxValue = viewModel.model.duration
        let minValue = 0
        let currentValue = viewModel.model.progress
        progressView.progress = Float(currentValue - minValue) / Float(maxValue - minValue)
        button.currentState = viewModel.model.currentState
        if viewModel.model.currentState == .running {
            let seconds = Int(viewModel.model.progress)
            let min = seconds / 60
            let sec = seconds % 60
            timerLabel.text = String(format: "%02d:%02d", min, sec)
            timerLabel.isHidden = false
        } else {
            timerLabel.isHidden = true
        }
     }
     
    @objc
    private func buttonTapped() {
        viewModel.signal()
    }
}
extension WarmUpCoolDownView{
    private func setupConstraints() {
        [
            titleLabel,
            descriptionLabel,
            imageView,
            progressView,
            button,
            timerLabel
        ].forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
         
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
             
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),

            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),

            progressView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -8),
            progressView.heightAnchor.constraint(equalToConstant: 4),
            progressView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            
            timerLabel.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            timerLabel.centerXAnchor.constraint(equalTo: button.centerXAnchor),
             
            button.widthAnchor.constraint(equalToConstant: 80),
            button.heightAnchor.constraint(equalToConstant: 30),
            button.topAnchor.constraint(greaterThanOrEqualTo: imageView.bottomAnchor, constant: 8),
            button.topAnchor.constraint(greaterThanOrEqualTo: descriptionLabel.bottomAnchor, constant: 8),
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12)
        ])
    }
}
