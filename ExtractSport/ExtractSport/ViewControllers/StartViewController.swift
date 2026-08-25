//
//  StartViewController.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class StartViewController: BaseViewController {
    
    private let viewModel: StartViewModelProtocol = StartViewModel()
    
    private let targetAreaButtonModels: [TargetArea] = [.legs, .armsAndShoulders, .back, .chest, .absAndCore, .fullBody]
    private let workoutTypeButtonModels: [WorkoutType] = [.strength, .endurance, .explosivePower, .circuit]
    private let equipmentButtonModels: [Equipment] = [.bodyweight, .homeGym, .outdoorPark, .gym]
    
    private var targetAreaButtons: [SetupButton] = []
    private var workoutTypeButtons: [SetupButton] = []
    private var equipmentButtons: [SetupButton] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        updateUI()
    }
    
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.updateUI()
        }
        viewModel.onNext = { [weak self] workoutModel in
            let setupViewController = SetupViewController(workoutModel: workoutModel)
            self?.navigationController?.pushViewController(setupViewController, animated: true)
        }
    }
    
    private func setupUI() {
        let mainStack = makeMainStack()
        let groups = makeAllGroups()
        let spacers = makeSpacers()
        mainStack.addArrangedSubview(spacers.top)
        mainStack.addArrangedSubview(groups.targetArea)
        mainStack.addArrangedSubview(spacers.middle1)
        mainStack.addArrangedSubview(groups.workoutType)
        mainStack.addArrangedSubview(spacers.middle2)
        mainStack.addArrangedSubview(groups.equipment)
        mainStack.addArrangedSubview(spacers.bottom)
        view.addSubview(mainStack)
        let nextButton = makeNextButton()
        view.addSubview(nextButton)
        setupConstraints(mainStack: mainStack, nextButton: nextButton, spacers: spacers)
    }
    
    private func makeMainStack() -> UIStackView {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
    
    private func makeSpacers() -> (top: UIView, middle1: UIView, middle2: UIView, bottom: UIView) {
        let top = UIView()
        let middle1 = UIView()
        let middle2 = UIView()
        let bottom = UIView()
        [top, middle1, middle2, bottom].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .clear
        }
        return (top, middle1, middle2, bottom)
    }
    
    private func makeAllGroups() -> (targetArea: UIStackView, workoutType: UIStackView, equipment: UIStackView) {
        let group1 = createGroup(
            title: "setupTitle.targetArea".localized,
            items: targetAreaButtonModels,
            isSelected: { [weak self] item in
                guard let self = self else { return false }
                return (item as? TargetArea) == self.viewModel.selectedTargetArea
            },
            storage: &targetAreaButtons
        )
        let group2 = createGroup(
            title: "setupTitle.workoutType".localized,
            items: workoutTypeButtonModels,
            isSelected: { [weak self] item in
                guard let self = self else { return false }
                return (item as? WorkoutType) == self.viewModel.selectedWorkoutType
            },
            storage: &workoutTypeButtons
        )
        let group3 = createGroup(
            title: "setupTitle.equipment".localized,
            items: equipmentButtonModels,
            isSelected: { [weak self] item in
                guard let self = self else { return false }
                return (item as? Equipment) == self.viewModel.selectedEquipment
            },
            storage: &equipmentButtons
        )
        return (group1, group2, group3)
    }
    
    private func makeNextButton() -> UIButton {
        let button = LargeButton(title: "largeButton.next".localized)
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }
    
    private func createGroup(title: String, items: [SetupProtocol], isSelected: @escaping (SetupProtocol) -> Bool, storage: inout [SetupButton]) -> UIStackView {
        let groupStack = UIStackView()
        groupStack.axis = .vertical
        groupStack.alignment = .fill
        groupStack.distribution = .fill
        groupStack.spacing = 10
        groupStack.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = UIColor(named: "labelText")
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        titleLabel.textAlignment = .center
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        groupStack.addArrangedSubview(titleLabel)
        groupStack.setCustomSpacing(28, after: titleLabel)

        for i in stride(from: 0, to: items.count, by: 2) {
            let item1 = items[i]
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.alignment = .fill
            rowStack.distribution = .fillEqually
            rowStack.spacing = 10
            rowStack.translatesAutoresizingMaskIntoConstraints = false
            
            let button1 = SetupButton(command: item1)
            button1.heightAnchor.constraint(equalToConstant: 30).isActive = true
            button1.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            button1.isSelected = isSelected(item1)
            storage.append(button1)
            rowStack.addArrangedSubview(button1)
            
            if i + 1 < items.count {
                let item2 = items[i + 1]
                let button2 = SetupButton(command: item2)
                button2.heightAnchor.constraint(equalToConstant: 30).isActive = true
                button2.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
                button2.isSelected = isSelected(item2)
                storage.append(button2)
                rowStack.addArrangedSubview(button2)
            } else {
                let spacer = UIView()
                spacer.backgroundColor = .clear
                rowStack.addArrangedSubview(spacer)
            }
            
            groupStack.addArrangedSubview(rowStack)
        }
        
        return groupStack
    }
    
    private func makeButton(for item: SetupProtocol, isSelected: @escaping (SetupProtocol) -> Bool) -> SetupButton {
        let button = SetupButton(command: item)
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        button.isSelected = isSelected(item)
        return button
    }

    @objc private func buttonTapped(_ sender: SetupButton) {
        viewModel.select(option: sender.command)
    }

    private func updateUI() {
        targetAreaButtons.forEach {
            $0.isSelected = ($0.command as? TargetArea) == viewModel.selectedTargetArea
        }
        workoutTypeButtons.forEach {
            $0.isSelected = ($0.command as? WorkoutType) == viewModel.selectedWorkoutType
        }
        equipmentButtons.forEach {
            $0.isSelected = ($0.command as? Equipment) == viewModel.selectedEquipment
        }
    }

    @objc
    private func nextButtonTapped() {
        viewModel.next()
    }
}


extension StartViewController {
    private func setupConstraints(mainStack: UIStackView, nextButton: UIButton, spacers: (top: UIView, middle1: UIView, middle2: UIView, bottom: UIView)) {
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            mainStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            mainStack.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -35),
            
            spacers.top.heightAnchor.constraint(equalTo: spacers.middle1.heightAnchor),
            spacers.top.heightAnchor.constraint(equalTo: spacers.middle2.heightAnchor),
            spacers.top.heightAnchor.constraint(equalTo: spacers.bottom.heightAnchor),
            
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
