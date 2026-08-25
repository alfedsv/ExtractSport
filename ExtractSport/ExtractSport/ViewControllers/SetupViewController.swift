//
//  SetupViewController.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import UIKit

final class SetupViewController: BaseViewController {
    
    private let viewModel: SetupViewModelProtocol
    
    private let firstSlider = UISlider()
    private let secondSlider = UISlider()

    private let firstTitleLabel = UILabel()
    private let secondTitleLabel = UILabel()

    private let firstValueLabel = UILabel()
    private let secondValueLabel = UILabel()
    
    private let recomendationView: RecomendationView

    private let nextButton = LargeButton(title: "largeButton.begin".localized)

    init(workoutModel: WorkoutModel) {
        self.viewModel = SetupViewModel(workoutModel: workoutModel)
        self.recomendationView = RecomendationView(workoutType: workoutModel.workoutType)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupValues()
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        viewModel.onUpdate = { [weak self] in
            self?.setupValues()
        }
        
        viewModel.onNext = { [weak self] workoutModel in
            let setupViewController = SetupViewController(workoutModel: workoutModel)
            self?.navigationController?.pushViewController(setupViewController, animated: true)
        }
    }
    
    private func setupUI() {
        firstTitleLabel.text = "Первый ползунок"
        firstTitleLabel.font = .systemFont(ofSize: 24)
        firstTitleLabel.textAlignment = .center
        firstTitleLabel.textColor = UIColor(named: "labelText")
        
        secondTitleLabel.text = "Второй ползунок"
        secondTitleLabel.font = .systemFont(ofSize: 24)
        secondTitleLabel.textAlignment = .center
        secondTitleLabel.textColor = UIColor(named: "labelText")

        firstSlider.minimumValue = Float(WorkoutModelConstants.workoutDurationMin)
        firstSlider.maximumValue = Float(WorkoutModelConstants.workoutDurationMax)
        firstSlider.isContinuous = true
        firstSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        firstSlider.minimumTrackTintColor = UIColor(named: "sliderActive")
        firstSlider.maximumTrackTintColor = UIColor(named: "sliderUnactive")

        secondSlider.minimumValue = Float(WorkoutModelConstants.exerciseCountMin)
        secondSlider.maximumValue = Float(WorkoutModelConstants.exerciseCountMax)
        secondSlider.isContinuous = true
        secondSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        secondSlider.minimumTrackTintColor = UIColor(named: "sliderActive")
        secondSlider.maximumTrackTintColor = UIColor(named: "sliderUnactive")

        [firstValueLabel, secondValueLabel].forEach { label in
            label.font = .systemFont(ofSize: 14)
            label.textColor = UIColor(named: "labelText")
            label.textAlignment = .left
        }

        nextButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        [firstTitleLabel, firstSlider, firstValueLabel, secondTitleLabel, secondSlider, secondValueLabel, nextButton, recomendationView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupValues() {
        firstSlider.value = Float(viewModel.workoutDuration)
        secondSlider.value = Float(viewModel.exerciseCount)
        firstValueLabel.text = String(viewModel.workoutDuration) + " " + "slider.minutes".localized
        secondValueLabel.text = String(viewModel.exerciseCount) + " " + "slider.variants".localized
    }

    @objc
    private func sliderValueChanged(_ slider: UISlider) {
        let rounded = round(slider.value)
        slider.value = rounded
        let intValue = Int(slider.value)
        if slider == firstSlider {
            viewModel.workoutDurationUpdate(minuts: intValue)
        } else if slider == secondSlider {
            viewModel.exerciseCountUpdate(count: intValue)
        }
    }

    @objc
    private func buttonTapped() {
        let firstVal = Int(firstSlider.value)
        let secondVal = Int(secondSlider.value)
        let message = "Первый: \(firstVal)\nВторой: \(secondVal)"
        let alert = UIAlertController(title: "Значения слайдеров", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

}
extension SetupViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            firstTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            firstTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstSlider.topAnchor.constraint(equalTo: firstTitleLabel.bottomAnchor, constant: 8),
            firstSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            firstValueLabel.topAnchor.constraint(equalTo: firstSlider.bottomAnchor, constant: 4),
            firstValueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            secondTitleLabel.topAnchor.constraint(equalTo: firstValueLabel.bottomAnchor, constant: 30),
            secondTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            secondSlider.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 8),
            secondSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            secondSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            secondValueLabel.topAnchor.constraint(equalTo: secondSlider.bottomAnchor, constant: 4),
            secondValueLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            recomendationView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recomendationView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            recomendationView.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -50),
            
            nextButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 45),
            nextButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -45),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            nextButton.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
}
