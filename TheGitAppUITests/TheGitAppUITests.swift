//
//  TheGitAppUITests.swift
//  TheGitAppUITests
//
//  Created by Stanciu Valentin on 17/06/2020.
//  Copyright © 2020 Stanciu Valentin. All rights reserved.
//

import XCTest

class TheGitAppUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments.append("-mockApi")
        app.launch()
                
        XCTAssertGreaterThanOrEqual(XCUIApplication().tables.cells.count, 1)
    }
    
    func testFailExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launchArguments.append("-mockApiFail")
        app.launch()
                
        XCTAssertEqual(XCUIApplication().tables.cells.count, 0)
    }
}
