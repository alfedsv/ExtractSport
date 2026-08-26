//
//  WarmUpCoolDownModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

struct WarmUpCoolDownModel {
    
    enum CurrentState {
        case running
        case begin
        case ended
    }
    
    let id: UUID
    let imageData: Data?
    let title: String
    let description: String
    var progress: Int = 0
    var duration: Int
    var currentState: CurrentState = .begin
    var isLocked: Bool = false
    
    mutating func setAsDone() {
        self.progress = self.duration
        self.currentState = .ended
        self.isLocked = false
    }
}
