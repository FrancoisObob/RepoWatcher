//
//  SelectSingleRepoIntent.swift
//  RepoWatcher
//
//  Created by Francois Lambert on 5/8/24.
//

import Foundation
import AppIntents

struct SelectSingleRepoIntent: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "SelectSingleRepoIntent"

    static var title: LocalizedStringResource = "Select Single Repo"
    static var description = IntentDescription("Choose a repository to watch")

    @Parameter(title: "Repo", optionsProvider: RepoOptionsProvider())
    var repo: String?

    struct RepoOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            guard let repos = UserDefaults.shared.value(forKey: UserDefaults.repoKey) as? [String] else { throw UserDefaultsError.retrieval }
            return repos
        }

        func defaultResult() async -> String? { "sallen0400/swift-news" }
    }
}
