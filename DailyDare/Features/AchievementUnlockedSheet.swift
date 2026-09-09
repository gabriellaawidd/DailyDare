//
//  AchievementUnlockedSheet.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 07/09/26.
//

import SwiftUI
import DailyDareKit

struct AchievementUnlockedSheet: View {
    let achievement: Achievement
    var onViewAllAchievements: () -> Void

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            VStack (spacing: 8) {
                Spacer()
                
                Image(systemName: achievement.iconName)
                    .font(.system(size: 80))
                    .foregroundStyle(.yellow)
                
                Spacer()
                
                Text(achievement.title)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Text("Congratulations! You have " + lowercasingFirstLetter(achievement.descriptionBack))
                    .font(.headline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)
                
                Spacer()
                
                Button {
                    dismiss()
                    onViewAllAchievements()
                } label: {
                    Text("View All Achievements")
                        .font(.headline)
                        .frame(maxWidth: 250)
                        .padding(.vertical, 14)
                }
                .buttonStyle(.borderedProminent)
                .foregroundStyle(.black)
                .padding(.horizontal)
                .padding(.bottom, 24)
                .tint(.yellow)
            }
            .navigationTitle("Achievement Unlock!")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .presentationDetents([.medium])
            .presentationBackground(.black)
        }
    }
    
    private func lowercasingFirstLetter(_ text: String) -> String {
        guard let first = text.first else { return text }
        return first.lowercased() + text.dropFirst()
    }
}



#Preview {
    Text("Today's Task")
        .sheet(isPresented: .constant(true)) {
            AchievementUnlockedSheet(achievement: MockData.achievements[0]) {}
        }
        .preferredColorScheme(.dark)
}
