//
//  SingleRepoWidget.swift
//  RepoWatcher
//
//  Created by Francois Lambert on 5/8/24.
//

import SwiftUI
import WidgetKit

struct SingleRepoProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SingleRepoEntry {
        SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }
    
    func snapshot(for configuration: SelectSingleRepoIntent, in context: Context) async -> SingleRepoEntry {
        SingleRepoEntry(date: .now, repo: MockData.repoOne)
    }
    
    func timeline(for configuration: SelectSingleRepoIntent, in context: Context) async -> Timeline<SingleRepoEntry> {
        let nextUpdate = Date().addingTimeInterval(60 * 60 * 12) // 12 hours in seconds

        do {
            let repoToShow = RepoURL.prefix + configuration.repo!

            // Get Repo
            var repo = try await NetworkManager.shared.getRepo(at: repoToShow)
            let avatarImageData = await NetworkManager.shared.downloadImageData(from: repo.owner.avatarUrl)
            repo.avatarData = avatarImageData ?? Data()

            if context.family == .systemLarge {
                // Get Contributors
                let contributors = try await NetworkManager.shared.getContributors(at: repoToShow + "/contributors")

                // Filter to just the top 4
                var topFour = Array(contributors.prefix(upTo: 4))

                // Download top four avatars
                for i in topFour.indices {
                    let avatarData = await NetworkManager.shared.downloadImageData(from: topFour[i].avatarUrl)
                    topFour[i].avatarData = avatarData ?? Data()
                }

                repo.contributors = topFour
            }

            // Create Entry & Timeline
            let entry = SingleRepoEntry(date: .now, repo: repo)
            return Timeline(entries: [entry], policy: .after(nextUpdate))
        } catch {
            print("❌ Error - \(error.localizedDescription)")
            return .init(entries: [], policy: .atEnd)
        }
    }
}

struct SingleRepoEntry: TimelineEntry {
    var date: Date
    let repo: Repository
}

struct SingleRepoEntryView : View {
    @Environment(\.widgetFamily) var family
    var entry: SingleRepoEntry

    var body: some View {
        switch family {
        case .systemMedium:
            RepoMediumView(repo: entry.repo)
        case .systemLarge:
            RepoMediumView(repo: entry.repo)
            ContributorMediumView(repo: entry.repo)
        case .accessoryInline:
            Text("\(entry.repo.name) - \(entry.repo.daysSinceLastActivity) days")
        case .accessoryCircular:
            ZStack {
                AccessoryWidgetBackground()
                VStack {
                    Text("\(entry.repo.daysSinceLastActivity)")
                        .font(.headline)
                    Text("days")
                        .font(.caption)
                }
            }

        case .accessoryRectangular:
            VStack(alignment: .leading) {
                Text(entry.repo.name)
                    .font(.headline)
                Text("\(entry.repo.daysSinceLastActivity) days")

                HStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .aspectRatio(contentMode: .fit)
                    Text("\(entry.repo.watchers)")

                    Image(systemName: "tuningfork")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .aspectRatio(contentMode: .fit)
                    Text("\(entry.repo.forks)")

                    if entry.repo.hasIssues {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .aspectRatio(contentMode: .fit)
                        Text("\(entry.repo.openIssues)")
                    }
                }
            }
        default:
            EmptyView()
        }
    }
}

@main
struct SingleRepoWidget: Widget {
    let kind: String = "SingleRepoWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: SelectSingleRepoIntent.self, provider: SingleRepoProvider()) { entry in
            if #available(iOS 17.0, *) {
                SingleRepoEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                SingleRepoEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("Single Repo")
        .description("Keep track of a single repository.")
        .supportedFamilies(
            [
                .systemMedium,
                .systemLarge,
                .accessoryInline,
                .accessoryCircular,
                .accessoryRectangular
            ]
        )
    }
}

#Preview(as: .systemMedium) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
}


#Preview(as: .systemLarge) {
    SingleRepoWidget()
} timeline: {
    SingleRepoEntry(date: .now, repo: MockData.repoOne)
}
