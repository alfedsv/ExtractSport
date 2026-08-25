//
//  SetupProtocol.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

protocol SetupProtocol {
    var localizedTitle: String { get }
    var activeBackgroundColor: String { get }
    var unactiveBackgroundColor: String { get }
    var setupType: SetupType { get }
    static var `default`: Self { get }
}
