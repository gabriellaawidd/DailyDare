//
//  Achievement.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 03/09/26.
//

import Foundation
import SwiftData

public enum UnlockRuleType: String, Codable {
    case firstTaskCompleted
    case allCategoriesTouched
    case streakReached
    case categoryFullyCompleted
    case allCategoriesFullyCompleted
    case recoveredFromMissedStreak
}

@Model
public final class Achievement {
    public var seedId: String?

    public var title: String
    public var iconName: String
    public var descriptionBack: String
    public var unlockRuleType: UnlockRuleType
    public var unlockRuleParam: String?
    public var unlockedDate: Date?

    public init(
        seedId: String,
        title: String,
        iconName: String,
        descriptionBack: String,
        unlockRuleType: UnlockRuleType,
        unlockRuleParam: String? = nil,
        unlockedDate: Date? = nil
    ) {
        self.seedId = seedId
        self.title = title
        self.iconName = iconName
        self.descriptionBack = descriptionBack
        self.unlockRuleType = unlockRuleType
        self.unlockRuleParam = unlockRuleParam
        self.unlockedDate = unlockedDate
    }
    
    public var isUnlocked: Bool { unlockedDate != nil }
}
