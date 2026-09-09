//
//  AchievementService.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 06/09/26.
//


import Foundation
import SwiftData

public enum AchievementService {

    public static let allCategories: [DailyTaskCategory] = [.selfSufficient, .reachingOut, .steadyMind]

    public static func checkUnlocks(context: ModelContext) -> [Achievement] {
        let achievements = (try? context.fetch(FetchDescriptor<Achievement>())) ?? []
        let tasks = (try? context.fetch(FetchDescriptor<DailyTask>())) ?? []
        guard let progress = (try? context.fetch(FetchDescriptor<UserProgress>()))?.first else { return [] }

        let completedTasks = tasks.filter { $0.status == .completedPermanently }
        var newlyUnlocked: [Achievement] = []

        for achievement in achievements where !achievement.isUnlocked {
            if isRuleSatisfied(achievement, tasks: tasks, completedTasks: completedTasks, progress: progress) {
                achievement.unlockedDate = .now
                newlyUnlocked.append(achievement)
            }
        }

        try? context.save()
        return newlyUnlocked
    }

    public static func isRuleSatisfied(
        _ achievement: Achievement,
        tasks: [DailyTask],
        completedTasks: [DailyTask],
        progress: UserProgress
    ) -> Bool {
        switch achievement.unlockRuleType {
        case .firstTaskCompleted:
            return !completedTasks.isEmpty

        case .allCategoriesTouched:
            let touchedCategories = Set(completedTasks.map { $0.category })
            return allCategories.allSatisfy { touchedCategories.contains($0) }

        case .streakReached:
            let target = Int(achievement.unlockRuleParam ?? "") ?? .max
            return progress.currentStreak >= target

        case .categoryFullyCompleted:
            guard let param = achievement.unlockRuleParam,
                  let category = DailyTaskCategory(rawValue: param) else { return false }
            let tasksInCategory = tasks.filter { $0.category == category }
            return !tasksInCategory.isEmpty && tasksInCategory.allSatisfy { $0.status == .completedPermanently }

        case .allCategoriesFullyCompleted:
            return allCategories.allSatisfy { category in
                let tasksInCategory = tasks.filter { $0.category == category }
                return !tasksInCategory.isEmpty && tasksInCategory.allSatisfy { $0.status == .completedPermanently }
            }

        case .recoveredFromMissedStreak:
            return progress.streakWasEverReset && progress.currentStreak >= 1
        }
    }
}
