//
//  WorkoutType.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

enum WorkoutType: String, SetupProtocol {
    
    case strength
    case endurance
    case explosivePower
    case circuit
    
    var localizedTitle: String {
        ("setupButton." + rawValue).localized
    }
    
    var activeBackgroundColor: String {
        "SetupButtonBackground/WorkoutType/active"
    }

    var unactiveBackgroundColor: String {
        "SetupButtonBackground/WorkoutType/unactive"
    }

    var setupType: SetupType {
        .workoutType
    }
    
    static var `default`: WorkoutType {
        .strength
    }
}
