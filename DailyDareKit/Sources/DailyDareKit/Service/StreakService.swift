//
//  StreakService.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 06/09/26.
//


import Foundation
import SwiftData

public enum StreakService {

    public static func resetStreakForMissedTask(context: ModelContext) {
        let descriptor = FetchDescriptor<UserProgress>()
        let progress: UserProgress
        if let existing = (try? context.fetch(descriptor))?.first {
            progress = existing
        } else {
            progress = UserProgress(currentStreak: 0)
            context.insert(progress)
        }

        guard progress.currentStreak != 0 else { return }

        progress.currentStreak = 0
        progress.streakWasEverReset = true
    }
}
