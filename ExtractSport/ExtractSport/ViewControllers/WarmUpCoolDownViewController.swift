//
//  WarmUpCoolDownViewController.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class WarmUpCoolDownViewController: BaseViewController {
    
    private let viewModel: WarmUpCoolDownViewModelProtocol
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24)
        label.textColor = UIColor(named: "labelText")
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    private let stackView = UIStackView()
    private let nextButton = LargeButton(title: "largeButton.next".localized)
    
    init(controllerType: WarmUpCoolDownViewModel.ControllerType, workoutModel: WorkoutModel) {
        self.viewModel = WarmUpCoolDownViewModel(controllerType: controllerType, workoutModel: workoutModel)
        switch controllerType {
        case .warmUp:
            titleLabel.text = "title.warmUp".localized
        case .coolDown:
            titleLabel.text = "title.coolDown".localized
        }
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        setupItems()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if isMovingFromParent {
            viewModel.back()
            print("Возвращаемся назад")
        }
        
    }
    
    private func bindViewModel() {
        viewModel.onShowWarning = { [weak self] controllerType in
            self?.showWarning(controllerType: controllerType)
        }
        
        viewModel.onNext = { [weak self] controllerType, workoutModel in
            switch controllerType {
            case .warmUp:
                let viewController = ExerciseViewController(workoutModel: workoutModel)
                self?.navigationController?.pushViewController(viewController, animated: true)
            case .coolDown:
                let viewController = FinishViewController()
                self?.navigationController?.pushViewController(viewController, animated: true)
            }
        }
    }

    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(stackView)
        contentView.addSubview(nextButton)

        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        stackView.distribution = .fill

        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupItems() {
        for viewModel in viewModel.itemViewModels {
            let itemView = WarmUpCoolDownView(viewModel: viewModel)
            stackView.addArrangedSubview(itemView)
        }
    }
    
    @objc
    private func nextButtonTapped() {
        viewModel.tryNext()
    }
    
    private func showWarning(controllerType: WarmUpCoolDownViewModel.ControllerType) {
        switch controllerType {
        case .warmUp:
            let alert = UIAlertController(title: "warnins.warmUp.title".localized, message: "warnins.warmUp.message".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "warnins.warmUp.back".localized, style: .default) { [weak self] _ in
                self?.dismiss(animated: true)
            })
            alert.addAction(UIAlertAction(title: "warnins.warmUp.goOn".localized, style: .default) { [weak self] _ in
                self?.viewModel.next()
            })
            present(alert, animated: true)
        case .coolDown:
            let alert = UIAlertController(title: "warnins.coolDown.title".localized, message: "warnins.coolDown.message".localized, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "warnins.coolDown.back".localized, style: .default) { [weak self] _ in
                self?.dismiss(animated: true)
            })
            alert.addAction(UIAlertAction(title: "warnins.coolDown.goOn".localized, style: .default) { [weak self] _ in
                self?.viewModel.next()
            })
            present(alert, animated: true)
        }
    }
    
}
extension WarmUpCoolDownViewController{
    private func setupConstraints() {
        [
            scrollView,
            contentView,
            titleLabel,
            stackView,
            nextButton
        ].forEach({ $0.translatesAutoresizingMaskIntoConstraints = false })
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),

            nextButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            nextButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 45),
            nextButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -45),
            nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            nextButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
