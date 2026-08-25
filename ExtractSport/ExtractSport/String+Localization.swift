//
//  String+Localization.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

extension String {
    var localized: String {
        String(localized: String.LocalizationValue(self))
    }
}
