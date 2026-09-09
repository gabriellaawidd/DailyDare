//
//  DailyDareApp.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 03/09/26.
//

import SwiftUI
import SwiftData
import DailyDareKit

@main
struct DailyDareApp: App {
    let container = ModelContainerFactory.makeContainer()
    
    var body: some Scene {
        WindowGroup {
            RootTabView()
                .preferredColorScheme(.dark)
                .onAppear() {
                    SeedDataLoader.seedIfNeeded(context: container.mainContext)
                }
        }
        .modelContainer(container)
    }
}
