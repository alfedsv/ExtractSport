//
//  WarmUpCoolDownModel.swift
//  ExtractSport
//
//  Created by  Alexander Fedoseev on 25.08.2026.
//

import Foundation

final class WarmUpCoolDownModel {
    
    let id: UUID
    let imageName: String
    let title: String
    let description: String
    var progress: Int = 0
    var duration: Int
    var currentState: CurrentState = .begin
    var isLocked: Bool = false
    
    init(id: UUID, imageName: String?, title: String, description: String, duration: Int, targetArea: TargetArea) {
        self.id = id
        if let imageName = imageName {
            self.imageName = imageName
        } else {
            self.imageName = Self.groupedImageName(targetArea: targetArea)
        }
        self.title = title
        self.description = description
        self.duration = duration
    }
    
    func setAsDone() {
        self.progress = self.duration
        self.currentState = .ended
        self.isLocked = false
    }
    
    private static func groupedImageName(targetArea: TargetArea) -> String {
        switch targetArea {
        case .legs:
            return "warmup_cooldown_legs"
        case .armsAndShoulders: 
            return "warmup_cooldown_arms"
        case .back:
            return "warmup_cooldown_back"
        case .chest:
            return "warmup_cooldown_chest"
        case .absAndCore:
            return "warmup_cooldown_core"
        case .fullBody:
            return "warmup_cooldown_fullbody"
        }
    }
    
}
