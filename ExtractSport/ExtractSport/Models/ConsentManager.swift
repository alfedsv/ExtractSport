//
//  ConsentManager.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 27.09.2026.
//

import Foundation

final class ConsentManager {
    
    static let shared = ConsentManager()
    static let currentTermsVersion = "1.0"
    
    private enum Keys {
        static let agreedVersion = "consent.agreedVersion"
        static let agreedDate    = "consent.agreedDate"
    }
    
    private let defaults = UserDefaults.standard
    
    private init() {}
    
    var needsConsent: Bool {
        let savedVersion = defaults.string(forKey: Keys.agreedVersion)
        return savedVersion != Self.currentTermsVersion
    }
    
    func saveConsent() {
        defaults.set(Self.currentTermsVersion, forKey: Keys.agreedVersion)
        defaults.set(Date(), forKey: Keys.agreedDate)
        if let date = defaults.object(forKey: Keys.agreedDate) as? Date {
            #if DEBUG
            print("✅ Consent saved: version \(Self.currentTermsVersion), date \(date)")
            #endif
        }
    }

    var consentDate: Date? {
        defaults.object(forKey: Keys.agreedDate) as? Date
    }
}
