//
//  AlbumAPI.swift
//  AlbumList
//
//  Created by Abin Baby on 26/10/20.
//

import Foundation

final class AlbumAPI {

    static let sharedInstance: AlbumAPI = AlbumAPI()

    init() {}

    func fetchAlbumsList(completion: @escaping (Result<[Album], Exception>) -> Void) {

        let urlString: String = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-albums/all/100/non-explicit.json"
        guard let url = URL(string: urlString) else {
            fatalError("Albums list URL not found")
        }

        let task: URLSessionTask = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(( _, let data)):
                    do {
                        let albumList: AlbumList = try JSONDecoder().decode(AlbumList.self, from: data)

                        completion(.success(albumList.feed.results))
                    } catch {
                        if let error: Exception = error as? Exception {
                            return completion(.failure(error))
                        }

                        completion(.failure(Exception.invalidFormat))
                    }
            case .failure:
                    completion(.failure(Exception.invalidFormat))
             }
        }
        task.resume()
    }
}

// MARK: - AlbumList
struct AlbumList: Codable {
    let feed: Feed
}

// MARK: - Feed
struct Feed: Codable {
    let results: [Album]
}

// MARK: - Result
struct Album: Codable {
    let artistName, id, name: String
    let artworkUrl100: String
}
