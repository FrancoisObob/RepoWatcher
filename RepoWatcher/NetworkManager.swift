//
//  NetworkManager.swift
//  RepoWatcher
//
//  Created by Francois Lambert on 5/1/24.
//

import Foundation

class NetworkManager {
    static let shared: NetworkManager = {
        let instance = NetworkManager()
        instance.decoder.keyDecodingStrategy = .convertFromSnakeCase
        instance.decoder.dateDecodingStrategy = .iso8601
        return instance
    }()

    let decoder = JSONDecoder()

    func getRepo(at urlString: String) async throws -> Repository {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidRepoURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let codingData = try decoder.decode(Repository.CodingData.self, from: data)
            return codingData.repo
        } catch {
            throw NetworkError.invalidRepoData
        }
    }

    func getContributors(at urlString: String) async throws -> [Contributor] {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidRepoURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }

        do {
            let codingData = try decoder.decode([Contributor.CodingData].self, from: data)
            return codingData.map { $0.contributor }
        } catch {
            throw NetworkError.invalidRepoData
        }
    }

    func downloadImageData(from urlString: String) async -> Data? {
        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return data
        } catch {
            return nil
        }
    }
}

enum NetworkError: Error {
    case invalidRepoURL
    case invalidResponse
    case invalidRepoData
}
