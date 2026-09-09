//
//  AchievementCard.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI
import DailyDareKit

struct AchievementCard: View {
    let achievement: Achievement
    
    @State private var isFlipped: Bool = false
    
    private static let dateFormatter: DateFormatter = {
           let formatter = DateFormatter()
           formatter.dateFormat = "dd/MM/yyyy"
           return formatter
       }()
    
    var body: some View {
        ZStack {
                   front
                       .opacity(isFlipped ? 0 : 1)
        
                   back
                       .opacity(isFlipped ? 1 : 0)
                       .rotation3DEffect(.degrees(180), axis: (x: 0, y: 1, z: 0))
               }
               .frame(width: 140, height: 170)
               .background(Color(white: 0.15), in: RoundedRectangle(cornerRadius: 16))
               .grayscale(achievement.isUnlocked ? 0 : 1)
               .opacity(achievement.isUnlocked ? 1 : 0.5)
               .rotation3DEffect(.degrees(isFlipped ? 180 : 0), axis: (x: 0, y: 1, z: 0))
               .onTapGesture {
                   guard achievement.isUnlocked else { return }
                   withAnimation(.easeInOut(duration: 0.5)) {
                       isFlipped.toggle()
                   }
               }
    }
    
    private var front: some View {
           VStack(spacing: 12) {
               Image(systemName: achievement.iconName)
                   .font(.system(size: 32))
                   .foregroundStyle(.yellow)
    
               Text(achievement.title)
                   .font(.subheadline.bold())
                   .multilineTextAlignment(.center)
                   .fixedSize(horizontal: false, vertical: true)
           }
           .padding(16)
       }
    
       private var back: some View {
           VStack(spacing: 8) {
               Text(achievement.descriptionBack)
                   .font(.caption)
                   .multilineTextAlignment(.center)
                   .fixedSize(horizontal: false, vertical: true)
    
               if let unlockedDate = achievement.unlockedDate {
                   Text(Self.dateFormatter.string(from: unlockedDate))
                       .font(.caption2)
                       .foregroundStyle(.secondary)
               }
           }
           .padding(16)
       }
}

#Preview {
    HStack(spacing: 16) {
        AchievementCard(achievement: MockData.achievements[0])
        AchievementCard(achievement: MockData.achievements[1])
    }
    .padding()
    .preferredColorScheme(.dark)
}
