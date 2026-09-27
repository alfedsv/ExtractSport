//
//  TermsContent.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 27.09.2026.
//

import Foundation

import UIKit

enum TermsContent {
    
    private static func loadMarkdown(named fileName: String) -> String? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "md"),
              let text = try? String(contentsOf: url, encoding: .utf8) else {
            return nil
        }
        return text
    }
    
    static var termsOfService: String {
        loadMarkdown(named: "TermsOfService") ?? "Terms of Service not found."
    }
    
    static var privacyPolicy: String {
        loadMarkdown(named: "PrivacyPolicy") ?? "Privacy Policy not found."
    }
    
    static func combinedAttributedText() -> NSAttributedString {
        let result = NSMutableAttributedString()
        
        let headerAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 18, weight: .bold),
            .foregroundColor: UIColor.label
        ]
        let bodyAttrs: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.label
        ]
        
        let termsHeader = NSLocalizedString("consent.legal.terms.header", comment: "Terms of Service header")
        let privacyHeader = NSLocalizedString("consent.legal.privacy.header", comment: "Privacy Policy header")
        
        result.append(NSAttributedString(string: termsHeader + "\n\n", attributes: headerAttrs))
        result.append(NSAttributedString(string: termsOfService + "\n\n\n", attributes: bodyAttrs))
        result.append(NSAttributedString(string: privacyHeader + "\n\n", attributes: headerAttrs))
        result.append(NSAttributedString(string: privacyPolicy, attributes: bodyAttrs))
        
        return result
    }
}
