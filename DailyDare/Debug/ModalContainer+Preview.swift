//
//  ModalContainer+Preview.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 06/09/26.
//

import SwiftData
import DailyDareKit

#if DEBUG
extension ModelContainer {
    @MainActor
    static var preview: ModelContainer {
        let schema = Schema([DailyTask.self, Achievement.self, UserProgress.self])
        let configuration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: schema, configurations: [configuration])

        let context = container.mainContext
        MockData.achievements.forEach { context.insert($0) }
        MockData.tasks.forEach { context.insert($0) }
        MockData.completedTasks.forEach { context.insert($0) }
        context.insert(UserProgress(currentStreak: MockData.currentStreak))

        return container
    }
}
#endif
