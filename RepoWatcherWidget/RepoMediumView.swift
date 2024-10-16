//
//  RepoMediumView.swift
//  RepoWatcherWidgetExtension
//
//  Created by Francois Lambert on 5/1/24.
//

import SwiftUI
import WidgetKit

struct RepoMediumView: View {
    let repo: Repository

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    if #available(iOS 18.0, *) {
                        Image(uiImage: UIImage(data: repo.avatarData) ?? .avatar)
                            .resizable()
                            .widgetAccentedRenderingMode(.accentedDesaturated)
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                    } else {
                        Image(uiImage: UIImage(data: repo.avatarData) ?? .avatar)
                            .resizable()
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                    }

                    Text(repo.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .minimumScaleFactor(0.6)
                        .lineLimit(1)
                        .widgetAccentable()
                }
                .padding(.bottom, 6)

                HStack {
                    StatLabel(value: repo.watchers, systemImageName: "star.fill")
                    StatLabel(value: repo.forks, systemImageName: "tuningfork")
                    if repo.hasIssues {
                        StatLabel(value: repo.openIssues, systemImageName: "exclamationmark.triangle.fill")
                    }
                }
            }

            Spacer()

            VStack {
                Text("\(String(describing: repo.daysSinceLastActivity))")
                    .bold()
                    .font(.system(size: 70))
                    .frame(width: 90, height: 80)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                    .foregroundStyle(daysSinceLastActivityColor)
                    .contentTransition(.numericText())
                    .widgetAccentable()

                Text("days ago")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }
        }
    }

    private var daysSinceLastActivityColor: Color {
        repo.daysSinceLastActivity > 50 ? .pink : .green
    }
}

fileprivate struct StatLabel: View {
    let value: Int
    let systemImageName: String

    var body: some View {
        Label(
            title: {
                Text("\(value)")
                    .font(.footnote)
                    .lineLimit(1)
                    .contentTransition(.numericText())
                    .widgetAccentable()
            },
            icon: {
                Image(systemName: systemImageName)
                    .foregroundStyle(.green)
            }
        )
        .fontWeight(.medium)
    }
}

#Preview(as: .systemMedium) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
    SingleRepoEntry(date: .now, repo: MockData.repoOneV2)
}

