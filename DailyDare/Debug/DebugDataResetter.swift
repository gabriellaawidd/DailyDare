//
//  DebugDataResetter.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 06/09/26.
//


import Foundation
import SwiftData
import WidgetKit
import DailyDareKit

#if DEBUG
enum DebugDataResetter {
    @MainActor
    static func resetAndReseed(context: ModelContext) {
        deleteAll(DailyTask.self, context: context)
        deleteAll(Achievement.self, context: context)
        deleteAll(UserProgress.self, context: context)
        try? context.save()

        SeedDataLoader.seedIfNeeded(context: context)
        WidgetCenter.shared.reloadTimelines(ofKind: "DailyDareWidget") 
    }

    @MainActor
    private static func deleteAll<T: PersistentModel>(_ type: T.Type, context: ModelContext) {
        let descriptor = FetchDescriptor<T>()
        guard let items = try? context.fetch(descriptor) else { return }
        items.forEach { context.delete($0) }
    }
}
#endif
