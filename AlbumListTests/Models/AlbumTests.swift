//
//  AlbumTests.swift
//  AlbumListTests
//
//  Created by Abin Baby on 28/10/20.
//

@testable import AlbumList
import XCTest

class AlbumTests: XCTestCase {

    var album: Album = Album(artistName: "",
                             id: "",
                             releaseDate: "",
                             name: "",
                             copyright: "",
                             artworkUrl100: "",
                             genres: [Genre(name: "")],
                             url: "")

    func testAlbumInit() {
        XCTAssertEqual(album.artistName, "")
        XCTAssertEqual(album.id, "")
        XCTAssertEqual(album.releaseDate, "")
        XCTAssertEqual(album.name, "")
        XCTAssertEqual(album.copyright, "")
        XCTAssertEqual(album.artworkUrl100, "")
        XCTAssertEqual(album.url, "")
    }

}
