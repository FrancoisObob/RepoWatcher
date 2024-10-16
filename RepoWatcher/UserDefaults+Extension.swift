//
//  UserDefaults+Extension.swift
//  Monthly
//
//  Created by Francois Lambert on 5/8/24.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        UserDefaults(suiteName: "group.com.flambert.RepoWatcher")!
    }

    static let repoKey = "repos"
}

enum UserDefaultsError: Error {
    case retrieval
}
