//
//  DailyDareProgressView.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//


import SwiftUI
import SwiftData
import DailyDareKit

struct DailyDareProgressView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Achievement.seedId) private var achievements: [Achievement]
    @Query private var allTasks: [DailyTask]
    
    #if DEBUG
    @State private var showResetConfirmation = false
    #endif
    
    private var completedTasks: [DailyTask] {
        allTasks.filter { $0.status == .completedPermanently }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    AchievementsPreviewScroll(achievements: achievements)
                    CompletedTasksPreview(tasks: completedTasks)
                }
                .padding()
            }
            .navigationTitle("Progress")
            .navigationBarTitleDisplayMode(.large)
            .dailyDareNavigationTheme()
            
        #if DEBUG
          .toolbar {
              ToolbarItem(placement: .topBarTrailing) {
                  Button {
                      showResetConfirmation = true
                  } label: {
                      Image(systemName: "arrow.counterclockwise")
                  }
              }
          }
          .alert("Reset all data?", isPresented: $showResetConfirmation) {
              Button("Reset", role: .destructive) {
                  DebugDataResetter.resetAndReseed(context: modelContext)
              }
              Button("Cancel", role: .cancel) {}
          } message: {
              Text("Reset all data for development purposes.")
          }
          #endif
        }
    }
}

#Preview {
    DailyDareProgressView()
        .modelContainer(.preview)
        .preferredColorScheme(.dark)
}
