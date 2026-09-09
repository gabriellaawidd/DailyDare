//
//  CompletedTaskCard.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI
import DailyDareKit

struct CompletedTaskCard: View {
    let task: DailyTask
    
    var body: some View {
        HStack(spacing: 12){
            Image(systemName: task.iconName)
                .font(.title)
                .frame(width: 48, height: 48)
            
            Text(task.title)
                .font(.body)
                .lineLimit(2)
            
            Spacer()
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
}

#Preview {
    CompletedTaskCard(task: MockData.completedTasks[0])
        .preferredColorScheme(.dark)
}
