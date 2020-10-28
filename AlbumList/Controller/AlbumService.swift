//
//  AlbumService.swift
//  AlbumList
//
//  Created by Abin Baby on 28/10/20.
//

import Foundation

class AlbumService {
    func fetchAlbumLists(completion: @escaping (Result<AlbumList, Exception>) -> Void ) {
        NetworkManager.sharedInstance.fetch { (result: Swift.Result<AlbumList, Exception>) in
            switch result {
            case .success(let dataArray):
                completion(.success(dataArray))
            case .failure:
                completion(.failure(Exception.undefined))
             }
        }
     }
}
