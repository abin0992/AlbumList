//
//  XCUITestBase.swift
//  AlbumListUITests
//
//  Created by Abin Baby on 28/10/20.
//

import XCTest

class XCUITestBase: XCTestCase {
    let app: XCUIApplication = XCUIApplication()

    let defaultLaunchArguments: [[String]] = {
        let launchArguments: [[String]] = [["-StartFromCleanState", "YES", "-Snapshot"]]
        return launchArguments
    }()

    func launchApp(with launchArguments: [[String]] = []) {
        (defaultLaunchArguments + launchArguments).forEach { app.launchArguments += $0 }
        app.launch()
    }

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        launchApp(with: defaultLaunchArguments)
    }

    override func tearDown() {
        app.terminate()
        super.tearDown()
    }
}
