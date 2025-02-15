//
//  AZPlayerUITests.swift
//  AZPlayerUITests
//
//  Created by Anouar Zemouri on 13/02/2025.
//

import XCTest

final class AZPlayerUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testExample() throws {
        let app = XCUIApplication()
        app.launch()

        
    }

}
