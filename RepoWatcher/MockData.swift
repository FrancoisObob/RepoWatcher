//
//  MockData.swift
//  RepoWatcher
//
//  Created by Francois Lambert on 5/8/24.
//

import Foundation

struct MockData {
    static let repoOne = Repository(
        name: "Repository 1",
        owner: Owner(
            avatarUrl: ""
        ),
        hasIssues: true,
        forks: 3,
        watchers: 321,
        openIssues: 123,
        pushedAt: "2024-04-27T00:29:36Z",
        avatarData: Data(),
        contributors: [
            Contributor(
                login: "Sean Allen",
                avatarUrl: "",
                contributions: 42,
                avatarData: Data()
            ),
            Contributor(
                login: "Michael Jordan",
                avatarUrl: "",
                contributions: 23,
                avatarData: Data()
            ),
            Contributor(
                login: "Steph Curry",
                avatarUrl: "",
                contributions: 30,
                avatarData: Data()
            ),
            Contributor(
                login: "LeBron James",
                avatarUrl: "",
                contributions: 6,
                avatarData: Data()
            )
        ]
    )
    
    static let repoOneV2 = Repository(
        name: "Repository 1",
        owner: Owner(
            avatarUrl: ""
        ),
        hasIssues: true,
        forks: 112,
        watchers: 327,
        openIssues: 100,
        pushedAt: "2023-10-09T18:19:30Z",
        avatarData: Data(),
        contributors: [
            Contributor(
                login: "Sean Allen",
                avatarUrl: "",
                contributions: 149,
                avatarData: Data()
            ),
            Contributor(
                login: "Michael Jordan",
                avatarUrl: "",
                contributions: 50,
                avatarData: Data()
            ),
            Contributor(
                login: "Steph Curry",
                avatarUrl: "",
                contributions: 39,
                avatarData: Data()
            ),
            Contributor(
                login: "LeBron James",
                avatarUrl: "",
                contributions: 16,
                avatarData: Data()
            )
        ]
    )


    static let repoTwo = Repository(
        name: "Repository 2",
        owner: Owner(
            avatarUrl: ""
        ),
        hasIssues: false,
        forks: 132,
        watchers: 9401,
        openIssues: 122,
        pushedAt: "2024-01-27T00:29:36Z",
        avatarData: Data()
    )
}
