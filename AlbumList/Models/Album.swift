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

    init(artistName: String, id: String, releaseDate: String, name: String, copyright: String, artworkUrl100: String, genres: [Genre], url: String) {
        self.artistName = artistName
        self.id = id
        self.releaseDate = releaseDate
        self.name = name
        self.copyright = copyright
        self.artworkUrl100 = artworkUrl100
        self.genres = genres
        self.url = url
    }
}

// MARK: - Genre
struct Genre: Codable {
    let name: String
}
