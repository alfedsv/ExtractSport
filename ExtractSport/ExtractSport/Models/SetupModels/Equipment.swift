//
//  Equipment.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

enum Equipment: String, SetupProtocol {
    case bodyweight
    case homeGym
    case outdoorPark
    case gym
    
    var localizedTitle: String {
        ("setupButton." + rawValue).localized
    }
    
    var activeBackgroundColor: String {
        "SetupButtonBackground/Equipment/active"
    }

    var unactiveBackgroundColor: String {
        "SetupButtonBackground/Equipment/unactive"
    }

    var setupType: SetupType {
        .equipment
    }
    
    static var `default`: Equipment{
        .gym
    }
}
