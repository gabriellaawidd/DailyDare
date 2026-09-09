//
//  TaskTimelineProvider.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 08/09/26.
//

import WidgetKit
import SwiftData
import DailyDareKit

struct TaskTimelineProvider: TimelineProvider {

    func placeholder(in context: Context) -> TaskEntry {
        TaskEntry(date: .now, task: nil, isCompletedToday: false)
    }

    func getSnapshot(in context: Context, completion: @escaping (TaskEntry) -> Void) {
        completion(currentEntry())
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<TaskEntry>) -> Void) {
        let entry = currentEntry()
        let nextRefresh = Calendar.current.date(byAdding: .minute, value: 15, to: .now) ?? .now
        completion(Timeline(entries: [entry], policy: .after(nextRefresh)))
    }

    private func currentEntry() -> TaskEntry {
        let container = ModelContainerFactory.makeContainer()
        let context = ModelContext(container)

        TaskGeneratorService.assignTaskIfNeeded(context: context)

        let activeTask = (try? context.fetch(FetchDescriptor<DailyTask>()))?
            .first(where: { $0.status == .active })

        let progress = (try? context.fetch(FetchDescriptor<UserProgress>()))?.first
        let isCompletedToday: Bool = {
            guard activeTask == nil, let lastCompleted = progress?.lastCompletedDate else { return false }
            return Calendar.current.isDateInToday(lastCompleted)
        }()

        return TaskEntry(date: .now, task: activeTask, isCompletedToday: isCompletedToday)
    }
}
