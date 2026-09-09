//
//  ActiveTaskWidgetView.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 08/09/26.
//


import SwiftUI
import DailyDareKit
import WidgetKit
import AppIntents

struct ActiveTaskWidgetView: View {
    let task: DailyTask

    var body: some View {
        HStack (spacing: 12) {
            Image("starMascot")
                .resizable()
                .frame(width: 80, height: 80)
            
            VStack(spacing: 12) {
                Text(task.title)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.white)
                    .lineLimit(2)
                
                Button(intent: MarkTaskDoneIntent(taskSeedId: task.seedId ?? "")) {
                    Text("I Did It!")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                        .foregroundStyle(.black)
                }
                .buttonStyle(.plain)
                .background(Color.yellow)
                .cornerRadius(16)
            }
        }
        .padding()
        .containerBackground(.black, for: .widget) 
    }
}

struct ActiveTaskWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        ActiveTaskWidgetView(task: MockData.tasks[0])
            .previewContext(WidgetPreviewContext(family: .systemMedium))
    }
}
