//
//  TaskGeneratorService.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 06/09/26.
//


import Foundation
import SwiftData

public enum TaskGeneratorService {

    public static func assignTaskIfNeeded(context: ModelContext) {
        let allTasks = (try? context.fetch(FetchDescriptor<DailyTask>())) ?? []

        moveExpiredActiveTaskToCooldownIfNeeded(in: allTasks, context: context)

        let hasActiveTask = allTasks.contains { $0.status == .active }
        let alreadyCompletedToday = allTasks.contains {
            guard let completedDate = $0.completedDate else { return false }
            return Calendar.current.isDateInToday(completedDate)
        }

        guard !hasActiveTask, !alreadyCompletedToday else {
            try? context.save()
            return
        }

        if let next = candidates(from: allTasks).randomElement() {
            next.status = .active
            next.assignedDate = .now
        }

        try? context.save()
    }

    public static func candidates(from tasks: [DailyTask]) -> [DailyTask] {
        tasks.filter { task in
            switch task.status {
            case .available:
                return true
            case .cooldown:
                return (task.cooldownUntil ?? .distantFuture) <= .now
            case .active, .completedPermanently:
                return false
            }
        }
    }

    public static func moveExpiredActiveTaskToCooldownIfNeeded(in tasks: [DailyTask], context: ModelContext) {
        guard let active = tasks.first(where: { $0.status == .active }),
              let assignedDate = active.assignedDate,
              !Calendar.current.isDateInToday(assignedDate) else { return }

        active.status = .cooldown
        active.cooldownUntil = Calendar.current.date(
            byAdding: .day,
            value: Int.random(in: 5...7),
            to: assignedDate
        )
        StreakService.resetStreakForMissedTask(context: context)
    }
}
