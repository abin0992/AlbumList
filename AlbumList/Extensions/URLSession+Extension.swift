//
//  URLSession+Extension.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import Foundation

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Exception>) -> Void) -> URLSessionDataTask {
        dataTask(with: url) { data, response, error in
            if let _: Error = error {
                result(.failure(Exception.notFound))
                return
            }
            guard let response = response, let data = data else {
                let _: Error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(Exception.undefined))
                return
            }
            result(.success((response, data)))
        }
    }
}
