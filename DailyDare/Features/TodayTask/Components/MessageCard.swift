//
//  MessageCard.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 04/09/26.
//

import SwiftUI

enum MessageType {
    case completedToday
    case completedAll
    
    var text: String {
        switch self {
        case .completedToday:
            return "You showed up for yourself today! That's what responsibility looks like"
        case .completedAll:
            return "You did it! You took responsibility for yourself!"
        }
    }
    
    var iconName: String {
        switch self {
        case .completedToday:
            return "heart.fill"
        case .completedAll:
            return "trophy.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .completedToday:
            return .red
        case .completedAll:
            return .yellow
        }
    }
}

struct MessageCard: View {
    let type: MessageType
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: type.iconName)
                .font(.system(size: 36))
                .foregroundStyle(type.iconColor)
            Text(type.text)
                .font(.headline)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: 250)
        .padding(20)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .cornerRadius(16)
    }
}

#Preview {
    MessageCard(type: .completedToday)
    MessageCard(type: .completedAll)
}
