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
    var albums: AlbumList = AlbumList()

    override func fetchAlbumLists(completion: @escaping (Result<AlbumList, Exception>) -> Void) {
        guard let jsonURL: URL = Bundle.main.url(forResource: testJSONFile, withExtension: "json") else {
            XCTFail("Loading file '\(testJSONFile).json' failed!")
            return
        }
        do {
            let data: Data = try Data(contentsOf: jsonURL)
            let result: T = try JSONDecoder().decode(AlbumList.self, from: data)

            guard let jsonData: [[String: Any]] = json["data"] as? [[String: Any]]  else {
                    throw RMException.invalidFormat
            }
            alerts = try RMAlertFactory.build(jsonData)

            completion { (alerts, pagination) }

        } catch {
            XCTFail("Reading contents of file '\(testJSONFile).json' failed! (Exception: \(error))")
        }
    }
}
