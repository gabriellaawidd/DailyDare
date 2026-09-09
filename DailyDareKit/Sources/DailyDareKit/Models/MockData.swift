//
//  MockData.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//


import Foundation

//Mock Data sebelum pakai Swift Data, masih hardcoded
public enum MockData {

    @MainActor public static let tasks: [DailyTask] = [
        DailyTask(
            seedId: "1",
            title: "Buy food by yourself at a canteen/food stall",
            category: .selfSufficient,
            iconName: DailyTaskCategory.selfSufficient.defaultIconName
        ),
        DailyTask(
            seedId: "2",
            title: "Greet someone you encounter, like a security guard or cleaning staff",
            category: .reachingOut,
            iconName: DailyTaskCategory.reachingOut.defaultIconName
        ),
        DailyTask(
            seedId: "3",
            title: "Eat alone without using your phone",
            category: .steadyMind,
            iconName: DailyTaskCategory.steadyMind.defaultIconName
        )
    ]

    @MainActor public static let achievements: [Achievement] = [
        Achievement(
            seedId: "1",
            title: "First Responsibility",
            iconName: "sparkle",
            descriptionBack: "Completed your very first task",
            unlockRuleType: .firstTaskCompleted,
            unlockedDate: .now
        ),
        Achievement(
            seedId: "2",
            title: "Well Rounded",
            iconName: "sparkles",
            descriptionBack: "Completed at least one task from each category",
            unlockRuleType: .allCategoriesTouched
        ),
        Achievement(
            seedId: "3",
            title: "3 Day Commitment",
            iconName: "flame",
            descriptionBack: "Followed through 3 days in a row",
            unlockRuleType: .streakReached,
            unlockRuleParam: "3"
        ),
        Achievement(
            seedId: "4",
            title: "1 Week Commitment",
            iconName: "flame.fill",
            descriptionBack: "7 days of showing up for yourself",
            unlockRuleType: .streakReached,
            unlockRuleParam: "7"
        ),
        Achievement(
            seedId: "5",
            title: "Self Reliant",
            iconName: "house.fill",
            descriptionBack: "Took full responsibility for every task in Self-Sufficient",
            unlockRuleType: .categoryFullyCompleted,
            unlockRuleParam: DailyTaskCategory.selfSufficient.rawValue
        )
    ]
    
    @MainActor public static let completedTasks: [DailyTask] = [
           DailyTask(
            seedId: "1",
               title: "Choose your own food spot without following a friend's choice",
               category: .selfSufficient,
               iconName: DailyTaskCategory.selfSufficient.defaultIconName,
               status: .completedPermanently,
               completedDate: Calendar.current.date(byAdding: .day, value: -1, to: .now)
           ),
           DailyTask(
            seedId: "2",
               title: "Greet someone at campus/office first, other than a close friend",
               category: .reachingOut,
               iconName: DailyTaskCategory.reachingOut.defaultIconName,
               status: .completedPermanently,
               completedDate: Calendar.current.date(byAdding: .day, value: -2, to: .now)
           ),
           DailyTask(
            seedId: "3",
               title: "Finish one task before opening social media",
               category: .steadyMind,
               iconName: DailyTaskCategory.steadyMind.defaultIconName,
               status: .completedPermanently,
               completedDate: Calendar.current.date(byAdding: .day, value: -3, to: .now)
           ),
           DailyTask(
            seedId: "4",
               title: "Make your bed after waking up",
               category: .selfSufficient,
               iconName: DailyTaskCategory.selfSufficient.defaultIconName,
               status: .completedPermanently,
               completedDate: Calendar.current.date(byAdding: .day, value: -5, to: .now)
           )
       ]

    public static let currentStreak: Int = 2
}
