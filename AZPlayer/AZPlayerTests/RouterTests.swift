//
//  RouterTests.swift
//  AZPlayerTests
//
//  Created by Anouar Zemouri on 15/02/2025.
//

@testable import AZPlayer
import SwiftUI
import XCTest

final class RouterTests: XCTestCase {
    var router: Router!

    override func setUp() {
        super.setUp()
        router = Router()
    }

    override func tearDown() {
        router = nil
        super.tearDown()
    }

    func testDestination() {
        let video = Video(
            id: "1",
            title: "Test Video",
            thumbnailUrl: "https://test.com/thumbnail.jpg",
            embedUrl: "https://test.com/embed_url"
        )
        let route = Route.player(video)

        let view = router.destination(for: route)

        XCTAssertNotNil(view)
    }
}
