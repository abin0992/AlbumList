//
//  AlbumDetailViewControllerTests.swift
//  AlbumListTests
//
//  Created by Abin Baby on 28/10/20.
//

@testable import AlbumList
import XCTest

class AlbumDetailViewControllerTests: XCTestCase {

    // MARK: - Subject under test

    var sut: AlbumDetailViewController!
    let testAlbum: Album = Album(artistName: "Test Artist",
                                 id: "123",
                                 releaseDate: "2020-11-27",
                                 name: "Test Name",
                                 copyright: "Test copyright",
                                 artworkUrl100: "https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/b9/c9/49/b9c949e6-d635-be2f-971d-81145effcf3d/886448810216.jpg/200x200bb.png",
                                 genres: [Genre(name: "pop")],
                                 url: "https://music.apple.com/us/album/plastic-hearts/1536966025?app=music")

    override func setUpWithError() throws {
        sut = AlbumDetailViewController()
        sut.album = testAlbum
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testAlbumImageView() {
        let albumImageViewIsSubView: Bool = sut.albumArtImageView.isDescendant(of: sut.view)
        XCTAssertTrue(albumImageViewIsSubView)
    }

    func testAlbumNameLabel() {
        let albumNameLabelIsSubView: Bool = sut.albumNameLabel.isDescendant(of: sut.view)
        XCTAssertTrue(albumNameLabelIsSubView)

        guard let displayedAlbumName: String = sut.albumNameLabel.text else {
            XCTFail("Album name label text not found")
            return
        }
        XCTAssertEqual(testAlbum.name, displayedAlbumName)
    }

    func testArtistNameLabel() {
        let artistNameLabelIsSubView: Bool = sut.artistNameLabel.isDescendant(of: sut.view)
        XCTAssertTrue(artistNameLabelIsSubView)

        guard let displayedArtistName: String = sut.artistNameLabel.text else {
            XCTFail("Artist name label text not found")
            return
        }
        XCTAssertEqual(testAlbum.artistName, displayedArtistName)
    }

    func testGenreLabel() {
        let genreLabelIsSubView: Bool = sut.genreLabel.isDescendant(of: sut.view)
        XCTAssertTrue(genreLabelIsSubView)

        guard let displayedGenre: String = sut.genreLabel.text else {
            XCTFail("Genre label text not found")
            return
        }

        let expectedGenre: String = sut.generateGenreLabel(from: testAlbum.genres)
        XCTAssertEqual(displayedGenre, expectedGenre)
    }

    func testReleasedLabel() {
        let releasedLabelIsSubView: Bool = sut.releaseDateLabel.isDescendant(of: sut.view)
        XCTAssertTrue(releasedLabelIsSubView)

        guard let displayedRelease: String = sut.releaseDateLabel.text else {
            XCTFail("Release label text not found")
            return
        }

        let expectedRelease: String = sut.generateReleaseDate(from: testAlbum.releaseDate)
        XCTAssertEqual(displayedRelease, expectedRelease)
    }

}
