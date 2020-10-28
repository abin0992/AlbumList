//
//  AlbumAPI.swift
//  AlbumList
//
//  Created by Abin Baby on 26/10/20.
//

import Foundation

class NetworkManager {

    static let sharedInstance: NetworkManager = NetworkManager()

    init() {}

    func fetch <T: Decodable>( completion: @escaping (Result<T, Exception>) -> Void) {

        guard let url = URL(string: String.Constants.albumsListUrl) else {
            fatalError("Albums list URL not found")
        }

        let task: URLSessionTask = URLSession.shared.dataTask(with: url) { result in
            switch result {
            case .success(( _, let data)):
                do {
                    let result: T = try JSONDecoder().decode(T.self, from: data)

                    completion(.success(result))
                } catch {
                    if let error: Exception = error as? Exception {
                        return completion(.failure(error))
                    }

                    completion(.failure(Exception.invalidFormat))
                }
            case .failure:
                    completion(.failure(Exception.undefined))
             }
        }
        task.resume()
    }
}
