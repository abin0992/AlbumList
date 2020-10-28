//
//  AlbumListControllerTests.swift
//  AlbumListTests
//
//  Created by Abin Baby on 28/10/20.
//

@testable import AlbumList
import XCTest

class AlbumListControllerTests: XCTestCase {

    // MARK: - Subject under test

    var sut: AlbumListController!
    let mockAlbumService: MockAlbumService = MockAlbumService()

    override func setUpWithError() throws {
        sut = AlbumListController()
        sut.albumService = mockAlbumService
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testControllerHasTableView() {
        XCTAssertNotNil(sut.tableView, "AlbumListController should have a tableview")
    }

    func testHasLoadingView() {
        let loadingView: UIView = sut.loadingView
        XCTAssertNotNil(loadingView)
    }

    func testLoadingViewIsVisible() {
        XCTAssertEqual(self.sut.tableView.backgroundView, self.sut.loadingView)
    }

    func testTableViewHasDataSource() {
        XCTAssertTrue(sut.tableView.dataSource is AlbumListController)

    }

    func testTableViewNumberOfRowsInSection() {
        sut.tableView.reloadData()
        let albumCount: Int = sut.albumsList.count
        XCTAssertEqual(albumCount, sut.tableView.numberOfRows(inSection: 0))
    }

    func testTableViewCellCreateCellsWithReuseIdentifier() {
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        let cell: UITableViewCell = sut.tableView(sut.tableView, cellForRowAt: indexPath)
        let expectedReuseIdentifier: String = sut.cellIdentifier
        XCTAssertTrue(cell.reuseIdentifier == expectedReuseIdentifier)
    }
}
