//
//  Contributor.swift
//  RepoWatcher
//
//  Created by Francois Lambert on 5/8/24.
//

import SwiftUI

struct Contributor: Identifiable {
    let id = UUID()
    let login: String
    let avatarUrl: String
    let contributions: Int

    var avatarData: Data
}

extension Contributor {
    struct CodingData: Decodable {
        let login: String
        let avatarUrl: String
        let contributions: Int

        var contributor: Contributor {
            Contributor(
                login: login,
                avatarUrl: avatarUrl,
                contributions: contributions,
                avatarData: Data()
            )
        }
    }
}
