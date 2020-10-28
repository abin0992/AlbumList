//
//  MockNetwork.swift
//  AlbumListTests
//
//  Created by Abin Baby on 28/10/20.
//

@testable import AlbumList
import Foundation
import XCTest

class NetworkMock: NetworkManager {
    static let sharedInstanceMock: NetworkMock = NetworkMock()
    let testJSONFile: String = "test_album"

    override func fetch <T: Decodable>( completion: @escaping (Result<T, Exception>) -> Void) {
        guard let jsonURL = Bundle(for: type(of: self)).url(forResource: testJSONFile, withExtension: "json") else {
            XCTFail("Loading file '\(self.testJSONFile).json' failed!")
            return
        }

        do {
            let data: Data = try Data(contentsOf: jsonURL)
            let result: T = try JSONDecoder().decode(T.self, from: data)

            completion(.success(result))

        } catch {
            XCTFail("Reading contents of file '\(testJSONFile).json' failed! (Exception: \(error))")
            completion(.failure(Exception.invalidFormat))
        }
    }
}
