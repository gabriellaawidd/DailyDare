//
//  CompletedTaskPreview.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI
import DailyDareKit

struct CompletedTasksPreview: View {
    let tasks: [DailyTask]

    private var sortedTasks: [DailyTask] {
        tasks.sorted { ($0.completedDate ?? .distantPast) > ($1.completedDate ?? .distantPast) }
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Completed Tasks")
                    .font(.title3.bold())
                    .foregroundStyle(.yellow)

                Spacer()

                NavigationLink("See All") {
                    AllCompletedTasksView(tasks: tasks)
                }
                .font(.subheadline)
                .foregroundStyle(.yellow)
            }

            if sortedTasks.isEmpty {
                Text("Tasks you complete will show up here.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.vertical, 8)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(sortedTasks) { task in
                        CompletedTaskCard(task: task)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        CompletedTasksPreview(tasks: MockData.completedTasks)
            .padding()
    }
    .preferredColorScheme(.dark)
}
