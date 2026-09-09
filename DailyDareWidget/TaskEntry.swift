//
//  Untitled.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 08/09/26.
//

import WidgetKit
import DailyDareKit

struct TaskEntry: TimelineEntry {
    let date: Date
    let task: DailyTask?
    let isCompletedToday: Bool 
}
