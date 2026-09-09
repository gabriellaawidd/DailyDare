//
//  RootTabView.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 03/09/26.
//

import SwiftUI

enum RootTab: Hashable {
    case todayTask
    case progress
}

struct RootTabView: View {
    @State private var selectedTab: RootTab = .todayTask

    var body: some View {
        TabView(selection: $selectedTab) {
            TodayTaskView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Today's Task", systemImage: "sparkles")
                }
                .tag(RootTab.todayTask)

            DailyDareProgressView()
                .tabItem {
                    Label("Progress", systemImage: "checkmark.seal")
                }
                .tag(RootTab.progress)
        }
        .tint(Color.yellow)
    }
}

#Preview {
    RootTabView()
        .preferredColorScheme(.dark)
}
