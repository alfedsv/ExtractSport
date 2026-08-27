//
//  String+Localization.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

// MARK: - Расширение для локализации строк
extension String {
    var localized: String {
        String(localized: String.LocalizationValue(self))
    }
}
