//
//  AllAchievementsView.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//


import SwiftUI
import DailyDareKit

struct AllAchievementsView: View {
    let achievements: [Achievement]

    private let columns = [
        GridItem(.flexible(), spacing: 8),
        GridItem(.flexible(), spacing: 8)
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(achievements) { achievement in
                    AchievementCard(achievement: achievement)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
        }
        .navigationTitle("All Achievements")
        .navigationBarTitleDisplayMode(.large)
        .dailyDareNavigationTheme()
        .toolbar(.hidden, for: .tabBar)
    }
}

#Preview {
    NavigationStack {
        AllAchievementsView(achievements: MockData.achievements)
    }
}
