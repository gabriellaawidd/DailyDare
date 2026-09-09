//
//  SeedDataLoader.swift
//  DailyDare
//
//  Created by Gabriella Angelina Widjaja on 05/09/26.
//

import Foundation
import SwiftData
import DailyDareKit

enum SeedDataLoader {

    private struct SeedTask: Decodable {
        let id: String
        let title: String
        let category: String
        let iconName: String?
    }

    private struct SeedAchievement: Decodable {
        let id: String
        let title: String
        let iconName: String
        let descriptionBack: String
        let unlockRuleType: String
        let unlockRuleParam: String?
    }

    @MainActor
    static func seedIfNeeded(context: ModelContext) {
        seedAchievementsIfNeeded(context: context)
        seedTasksIfNeeded(context: context)
        seedUserProgressIfNeeded(context: context)
    }

    @MainActor
    private static func seedAchievementsIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<Achievement>()
        guard (try? context.fetchCount(descriptor)) == 0 else { return }

        guard let seeds: [SeedAchievement] = decodeJSON(named: "seed_achievements") else { return }

        for seed in seeds {
            guard let ruleType = UnlockRuleType(rawValue: seed.unlockRuleType) else {
                print("SeedDataLoader: unlockRuleType tidak dikenal -> \"\(seed.unlockRuleType)\" (id: \(seed.id))")
                continue
            }
            context.insert(Achievement(
                seedId: seed.id,
                title: seed.title,
                iconName: seed.iconName,
                descriptionBack: seed.descriptionBack,
                unlockRuleType: ruleType,
                unlockRuleParam: seed.unlockRuleParam
            ))
        }
        try? context.save()
    }

    @MainActor
    private static func seedTasksIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<DailyTask>()
        guard (try? context.fetchCount(descriptor)) == 0 else { return }

        guard let seeds: [SeedTask] = decodeJSON(named: "seed_tasks") else { return }

        for seed in seeds {
            guard let category = DailyTaskCategory(rawValue: seed.category) else {
                print("SeedDataLoader: category tidak dikenal -> \"\(seed.category)\" (id: \(seed.id))")
                continue
            }
            context.insert(DailyTask(
                seedId: seed.id,
                title: seed.title,
                category: category,
                iconName: seed.iconName ?? category.defaultIconName
            ))
        }
        try? context.save()
    }

    @MainActor
    private static func seedUserProgressIfNeeded(context: ModelContext) {
        let descriptor = FetchDescriptor<UserProgress>()
        guard (try? context.fetchCount(descriptor)) == 0 else { return }

        context.insert(UserProgress(currentStreak: 0))
        try? context.save()
    }

    private static func decodeJSON<T: Decodable>(named name: String) -> T? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "json") else {
            print("SeedDataLoader: \(name).json nggak ketemu di bundle — sudah di-drag ke project & Target Membership-nya dicentang?")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            print("SeedDataLoader: gagal decode \(name).json -> \(error)")
            return nil
        }
    }
}
