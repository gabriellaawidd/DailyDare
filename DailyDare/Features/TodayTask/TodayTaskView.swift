//
//  TodayTaskView.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI
import SwiftData
import DailyDareKit

struct TodayTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Binding var selectedTab: RootTab

    @Query private var tasks: [DailyTask]
    @Query private var progressList: [UserProgress]

    @State private var isBreathing = false
    @State private var starScale: CGFloat = 1.0

    @State private var pendingAchievements: [Achievement] = []
    @State private var achievementToShow: Achievement?

    private var userProgress: UserProgress? { progressList.first }

    private var activeTask: DailyTask? {
        tasks.first(where: { $0.status == .active })
    }

    private var isCompletedToday: Bool {
        guard activeTask == nil, let lastCompleted = userProgress?.lastCompletedDate else { return false }
        return Calendar.current.isDateInToday(lastCompleted)
    }

    private var isPoolExhausted: Bool {
        guard activeTask == nil, !isCompletedToday else { return false }
        return TaskGeneratorService.candidates(from: tasks).isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                StreakCounterCard(streak: userProgress?.currentStreak ?? 0)

                Image("starMascot")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 250, height: 250)
                    .scaleEffect((isBreathing ? 1.03 : 1.0) * starScale)
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.6).repeatForever(autoreverses: true)) {
                            isBreathing = true
                        }
                    }

                if isPoolExhausted {
                    MessageCard(type: .completedAll)
                } else if isCompletedToday {
                    MessageCard(type: .completedToday)
                } else if let task = activeTask {
                    TodayTaskCard(task: task) {
                        markTaskDone(task)
                    }
                } else {
                    ProgressView()
                }

                Spacer()
            }
            .navigationTitle("Today's Task")
            .navigationBarTitleDisplayMode(.large)
            .dailyDareNavigationTheme()
            .padding(.vertical, 24)
            .onAppear {
                TaskGeneratorService.assignTaskIfNeeded(context: modelContext)
            }
            .sheet(item: $achievementToShow, onDismiss: {
                if !pendingAchievements.isEmpty {
                    achievementToShow = pendingAchievements.removeFirst()
                }
            }) { achievement in
                AchievementUnlockedSheet(achievement: achievement) {
                    selectedTab = .progress
                }
            }
        }
    }

    private func markTaskDone(_ task: DailyTask) {
        bounceStar()

        withAnimation(.easeInOut(duration: 0.3)) {
            task.status = .completedPermanently
            task.completedDate = .now

            let progress: UserProgress
            if let existing = userProgress {
                progress = existing
            } else {
                progress = UserProgress(currentStreak: 0)
                modelContext.insert(progress)
            }
            progress.currentStreak += 1
            progress.lastCompletedDate = .now

            try? modelContext.save()
        }

        let unlocked = AchievementService.checkUnlocks(context: modelContext)
        if !unlocked.isEmpty {
            pendingAchievements = unlocked
            achievementToShow = pendingAchievements.removeFirst()
        }
    }

    private func bounceStar() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.4)) {
            starScale = 1.2
        } completion: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.6)) {
                starScale = 1.0
            }
        }
    }
}

#Preview {
    TodayTaskView(selectedTab: .constant(.todayTask))
        .modelContainer(.preview)
        .preferredColorScheme(.dark)
}
