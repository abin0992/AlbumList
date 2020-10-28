//
//  NetworkManagerTests.swift
//  AlbumListTests
//
//  Created by Abin Baby on 28/10/20.
//

@testable import AlbumList
import XCTest

class NetworkManagerTests: XCTestCase {

    let networkMock: NetworkMock = NetworkMock.sharedInstanceMock

    func testFetchingAlbums() {
        let albumsExpectation: XCTestExpectation = expectation(description: "albums")

        networkMock.fetch { (result: Swift.Result<AlbumList, Exception>) in
            switch result {
            case .success:
                albumsExpectation.fulfill()
            case .failure:
                XCTFail()
             }
        }
        waitForExpectations(timeout: 5.0, handler: nil)
    }

}
