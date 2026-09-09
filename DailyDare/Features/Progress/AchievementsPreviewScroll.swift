//
//  AchievementsPreviewScroll.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//


import SwiftUI
import DailyDareKit

struct AchievementsPreviewScroll: View {
    let achievements: [Achievement]

    private var sortedAchievements: [Achievement] {
        let unlocked = achievements
            .filter { $0.isUnlocked }
            .sorted { ($0.unlockedDate ?? .distantPast) > ($1.unlockedDate ?? .distantPast) }
        let locked = achievements.filter { !$0.isUnlocked }
        return unlocked + locked
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Achievements")
                    .font(.title3.bold())
                    .foregroundStyle(.yellow)

                Spacer()

                NavigationLink("See All") {
                    AllAchievementsView(achievements: achievements)
                }
                .font(.subheadline)
                .foregroundStyle(.yellow)
            }

            ScrollView(.horizontal, showsIndicators: true) {
                LazyHStack(spacing: 16) {
                    ForEach(sortedAchievements) { achievement in
                        AchievementCard(achievement: achievement)
                    }
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AchievementsPreviewScroll(achievements: MockData.achievements)
            .padding()
    }
    .preferredColorScheme(.dark)
}
