//
//  DailyDareWidget.swift
//  DailyDareWidget
//
//  Created by Gabriella Angelina Widjaja on 08/09/26.
//

import WidgetKit
import SwiftUI
import DailyDareKit

struct DailyDareWidget: Widget {
    let kind: String = "DailyDareWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: TaskTimelineProvider()) { entry in
            if entry.isCompletedToday {
                CompletedTaskWidgetView()
            } else if let task = entry.task {
                ActiveTaskWidgetView(task: task)
            } else {
                CompletedTaskWidgetView()
            }
        }
        .configurationDisplayName("Today's Task")
        .description("View and complete your daily task.")
        .supportedFamilies([.systemMedium])
    }
}

#Preview(as: .systemMedium) {
    DailyDareWidget()
} timeline: {
    TaskEntry(date: .now, task: MockData.tasks[0], isCompletedToday: false)
    TaskEntry(date: .now, task: nil, isCompletedToday: true)
}
