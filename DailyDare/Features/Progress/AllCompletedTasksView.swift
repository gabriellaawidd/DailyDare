//
//  AllCompletedTasksView.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//


import SwiftUI
import DailyDareKit

struct AllCompletedTasksView: View {
    let tasks: [DailyTask]
    
    private var sortedTasks: [DailyTask] {
        tasks.sorted { ($0.completedDate ?? .distantPast) > ($1.completedDate ?? .distantPast) }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(sortedTasks) { task in
                    CompletedTaskCard(task: task)
                }
            }
            .padding()
        }
        .navigationTitle("All Completed Tasks")
        .navigationBarTitleDisplayMode(.large)
        .dailyDareNavigationTheme()
    }
}

#Preview {
    NavigationStack {
        AllCompletedTasksView(tasks: MockData.completedTasks)
    }
    .preferredColorScheme(.dark)
}
