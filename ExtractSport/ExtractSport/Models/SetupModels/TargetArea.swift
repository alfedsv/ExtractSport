//
//  TargetArea.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

enum TargetArea: String, SetupProtocol {
    case legs
    case armsAndShoulders
    case back
    case chest
    case absAndCore
    case fullBody
    
    var localizedTitle: String {
        ("setupButton." + rawValue).localized
    }
    
    var activeBackgroundColor: String {
        "SetupButtonBackground/TargetArea/active"
    }

    var unactiveBackgroundColor: String {
        "SetupButtonBackground/TargetArea/unactive"
    }

    var setupType: SetupType {
        .targetArea
    }
    
    static var `default`: TargetArea {
        .fullBody
    }
}
