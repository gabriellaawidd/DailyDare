//
//  MarkTaskDoneIntent.swift
//  DailyDareKit
//
//  Created by Gabriella Angelina Widjaja on 08/09/26.
//

import AppIntents
import SwiftData
import WidgetKit

public struct MarkTaskDoneIntent: AppIntent {
    public static let title: LocalizedStringResource = "Mark Task Done"
    public static let description = IntentDescription("Tandai task hari ini sebagai selesai.")
    public static let openAppWhenRun: Bool = false

    @Parameter(title: "Task Seed ID")
    public var taskSeedId: String

    public init() {
        self.taskSeedId = ""
    }

    public init(taskSeedId: String) {
        self.taskSeedId = taskSeedId
    }

    @MainActor
    public func perform() async throws -> some IntentResult {
        let context = ModelContext(ModelContainerFactory.makeContainer())

        guard let task = (try? context.fetch(FetchDescriptor<DailyTask>()))?
            .first(where: { $0.seedId == taskSeedId }) else {
            return .result()
        }

        guard task.status != .completedPermanently else {
            return .result()
        }

        task.status = .completedPermanently
        task.completedDate = .now

        let progress: UserProgress
        if let existing = (try? context.fetch(FetchDescriptor<UserProgress>()))?.first {
            progress = existing
        } else {
            progress = UserProgress(currentStreak: 0)
            context.insert(progress)
        }
        progress.currentStreak += 1
        progress.lastCompletedDate = .now

        try? context.save()

        AchievementService.checkUnlocks(context: context)

        WidgetCenter.shared.reloadTimelines(ofKind: "DailyDareWidget")

        return .result()
    }
}
