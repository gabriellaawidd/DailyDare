//
//  ModelContainerFactory.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 05/09/26.
//


import SwiftData

public enum ModelContainerFactory {
    public static func makeContainer() -> ModelContainer {
        let schema = Schema([
            DailyTask.self,
            Achievement.self,
            UserProgress.self
        ])

        let configuration = ModelConfiguration(
            schema: schema,
            groupContainer: .identifier("group.com.gabriellaawidd.DailyDare")
        )

        do {
            return try ModelContainer(for: schema, configurations: [configuration])
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
}
