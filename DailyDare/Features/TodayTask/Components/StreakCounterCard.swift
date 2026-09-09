//
//  StreakCounterCard.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI

struct StreakCounterCard: View {
    let streak: Int
    
    private var label: String {
        streak <= 1 ? "day streak!" : "days streak!"
    }
    
    var body: some View {
        HStack(spacing: 24) {
            Image(systemName: "flame.fill")
                .foregroundStyle(streak > 0 ? .orange : .gray)
                .font(.system(size: 48))
                        
            VStack (alignment: .leading) {
                Text("\(streak)")
                    .font(.title)
                    .fontWeight(streak > 0 ? .bold : .regular)
                
                Text(label)
                    .font(.subheadline)
            }
        }
        .frame(maxWidth: 250)
        .padding(.horizontal, 24)
        .padding(.vertical, 12)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
}

#Preview {
    VStack(spacing: 16) {
        StreakCounterCard(streak: 0)
        StreakCounterCard(streak: 1)
        StreakCounterCard(streak: 7)
    }
    .padding()
    .preferredColorScheme(.dark)
}
