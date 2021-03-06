//
//  MockAlbumService.swift
//  AlbumListTests
//
//  Created by Abin Baby on 28/10/20.
//

@testable import AlbumList
import XCTest

class MockAlbumService: AlbumService {
    let testJSONFile: String = "test_album"

    override func fetchAlbumLists(completion: @escaping (Result<AlbumList, Exception>) -> Void) {
        guard let jsonURL = Bundle(for: type(of: self)).url(forResource: testJSONFile, withExtension: "json") else {
            XCTFail("Loading file '\(testJSONFile).json' failed!")
            return
        }

        do {
            let data: Data = try Data(contentsOf: jsonURL)
            let result: AlbumList = try JSONDecoder().decode(AlbumList.self, from: data)

            completion(.success(result))

        } catch {
            XCTFail("Reading contents of file '\(testJSONFile).json' failed! (Exception: \(error))")
            completion(.failure(Exception.invalidFormat))
        }
    }
}
