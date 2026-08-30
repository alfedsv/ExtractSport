//
//  WarmUpCoolDownModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

final class WarmUpCoolDownModel {
    
    let id: UUID
    let imageData: Data?
    let title: String
    let description: String
    var progress: Int = 0
    var duration: Int
    var currentState: CurrentState = .begin
    var isLocked: Bool = false
    
    init(id: UUID, imageData: Data?, title: String, description: String, duration: Int) {
        self.id = id
        self.imageData = imageData
        self.title = title
        self.description = description
        self.duration = duration
    }
    
    func setAsDone() {
        self.progress = self.duration
        self.currentState = .ended
        self.isLocked = false
    }
}
