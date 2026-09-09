//
//  UserProgress.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 05/09/26.
//

import Foundation
import SwiftData

@Model
public final class UserProgress {
    public var currentStreak: Int
    public var lastCompletedDate: Date?
    public var streakWasEverReset: Bool
    
    public init(
        currentStreak: Int,
        lastCompletedDate: Date? = nil,
        streakWasEverReset: Bool = false
    ){
        self.currentStreak = currentStreak
        self.lastCompletedDate = lastCompletedDate
        self.streakWasEverReset = streakWasEverReset
    }
}
