//
//  Album.swift
//  AlbumList
//
//  Created by Abin Baby on 27/10/20.
//

import Foundation

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
    let artistName, id, releaseDate, name: String
    let copyright: String
    let artworkUrl100: String
    let genres: [Genre]
    let url: String
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
}
