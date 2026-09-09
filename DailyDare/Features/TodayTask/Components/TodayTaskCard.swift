//
//  TodayTaskCard.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI
import DailyDareKit

struct TodayTaskCard: View {
    let task: DailyTask
    let onDone: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: task.iconName)
                .font(.title)
            
            Text(task.title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            
            Button(action: onDone) {
                Text("I Did It!")
                    .font(.headline)
                    .foregroundStyle(Color.black)
                    .frame(maxWidth: 100)
                    .padding(.vertical, 4)
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: 250)
        .padding(24)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
}

#Preview {
    TodayTaskCard(task: MockData.tasks[0]) {
        print("I Did It! tapped")
    }
    .padding()
}
