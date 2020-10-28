//
//  AlbumListViewTests.swift
//  AlbumListUITests
//
//  Created by Abin Baby on 28/10/20.
//

import XCTest

class AlbumListViewTests: XCUITestBase {

    func testNavigationToDetailViewController() {

        // 1. Loads albums list
        checkAlbumListIsShown()

        // 2. Clicking on a cell
        let albumsTable: XCUIElementQuery = app.tables.matching(identifier: AccessibilityIdentifier.AlbumListTableView.rawValue)
        let cell: XCUIElement = albumsTable.cells.element(matching: .cell, identifier: "\(AccessibilityIdentifier.AlbumListTableCell.rawValue)_0")
        XCTAssertNotNil(cell.exists)
        cell.tap()

        //. Should display detail view controller
        checkAlbumDetailIsShown()

        XCTAssertTrue(app.buttons[AccessibilityIdentifier.VisitStoreButton.rawValue].staticTexts["View in iTunes store"].exists)
    }

    func checkAlbumListIsShown() {
        let albumListView: XCUIElement = app.otherElements[AccessibilityIdentifier.AlbumListView.rawValue]
        let albumListShown: Bool = albumListView.waitForExistence(timeout: 5)
        XCTAssertTrue(albumListShown)
    }

    func checkAlbumDetailIsShown() {
        let albumDetailView: XCUIElement = app.otherElements[AccessibilityIdentifier.AlbumDetailView.rawValue]
        let albumDetailShown: Bool = albumDetailView.waitForExistence(timeout: 5)
        XCTAssertTrue(albumDetailShown)
    }

}
