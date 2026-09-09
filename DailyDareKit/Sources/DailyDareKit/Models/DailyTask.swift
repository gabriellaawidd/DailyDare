//
//  Task.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 03/09/26.
//

import Foundation
import SwiftData

public enum DailyTaskCategory: String, Codable, Sendable {
    case selfSufficient = "Self-Sufficient"
    case reachingOut = "Reaching Out"
    case steadyMind = "Steady Mind"

    public var defaultIconName: String {
        switch self {
        case .selfSufficient: return "house.fill"
        case .reachingOut: return "person.2.fill"
        case .steadyMind: return "moon.stars.fill"
        }
    }
}

public enum DailyTaskStatus: String, Codable {
    case available
    case active
    case completedPermanently
    case cooldown
}

@Model
public final class DailyTask {
    public var seedId: String?
    public var title: String
    public var category: DailyTaskCategory
    public var iconName: String
    public var status: DailyTaskStatus
    public var assignedDate: Date?
    public var cooldownUntil: Date?
    public var completedDate: Date?

    public init(
        seedId: String,
        title: String,
        category: DailyTaskCategory,
        iconName: String,
        status: DailyTaskStatus = .available,
        assignedDate: Date? = nil,
        cooldownUntil: Date? = nil,
        completedDate: Date? = nil
    ) {
        self.seedId = seedId
        self.title = title
        self.category = category
        self.iconName = iconName
        self.status = status
        self.assignedDate = assignedDate
        self.cooldownUntil = cooldownUntil
        self.completedDate = completedDate
    }
}
