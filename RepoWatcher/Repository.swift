//
//  Repository.swift
//  RepoWatcher
//
//  Created by Francois Lambert on 4/30/24.
//

import SwiftUI

struct Repository {
    let name: String
    let owner: Owner
    let hasIssues: Bool
    let forks: Int
    let watchers: Int
    let openIssues: Int
    let pushedAt: String

    var avatarData: Data
    var contributors: [Contributor] = []

    var daysSinceLastActivity: Int {
        let formatter = ISO8601DateFormatter()
        let lastActivityDate = formatter.date(from: pushedAt) ?? .now
        return Calendar.current.dateComponents([.day], from: lastActivityDate, to: .now).day ?? 0
    }
}

extension Repository {
    struct CodingData: Decodable {
        let name: String
        let owner: Owner
        let hasIssues: Bool
        let forks: Int
        let watchers: Int
        let openIssues: Int
        let pushedAt: String

        var repo: Repository {
            Repository(
                name: name,
                owner: owner,
                hasIssues: hasIssues,
                forks: forks,
                watchers: watchers,
                openIssues: openIssues,
                pushedAt: pushedAt,
                avatarData: Data()
            )
        }
    }
}

struct Owner: Decodable {
    let avatarUrl: String
}

enum RepoURL {
    static let prefix = "https://api.github.com/repos/"

    static let swiftNews = "https://api.github.com/repos/sallen0400/swift-news"
    static let publish = "https://api.github.com/repos/johnsundell/publish"
    static let google = "https://api.github.com/repos/google/GoogleSignIn-iOS"
}
