//
//  ContributorMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Francois Lambert on 5/8/24.
//

import SwiftUI
import WidgetKit

struct ContributorMediumView: View {
    
    let repo: Repository

    var body: some View {
        VStack {
            HStack {
                Text("Top contributors")
                    .font(.caption)
                    .bold()
                    .foregroundStyle(.secondary)
                Spacer()
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 2),
                      alignment: .leading,
                      spacing: 20) {
                ForEach(repo.contributors) { contributor in
                    HStack {
                        if #available(iOS 18.0, *) {
                            Image(uiImage: UIImage(data: contributor.avatarData) ?? .avatar)
                                .resizable()
                                .widgetAccentedRenderingMode(.accentedDesaturated)
                                .frame(width: 44, height: 44)
                                .clipShape(.circle)
                        } else {
                            Image(uiImage: UIImage(data: contributor.avatarData) ?? .avatar)
                                .resizable()
                                .frame(width: 44, height: 44)
                                .clipShape(.circle)
                        }
                        VStack(alignment: .leading) {
                            Text(contributor.login)
                                .font(.caption)
                                .minimumScaleFactor(0.7)
                            Text("\(contributor.contributions)")
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }

            if repo.contributors.count < 3 {
                Spacer()
            }
        }
        .padding(.top)
    }
}

#Preview(as: .systemLarge) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
    SingleRepoEntry(date: .now, repo: MockData.repoOneV2)
}

