//
//  PlayerViewModelTests.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

@testable import AZPlayer
import XCTest

final class PlayerViewModelTests: XCTestCase {
    var viewModel: PlayerViewModel!
    var mockAPI: VideoAPIMock!

    override func setUp() {
        super.setUp()
        mockAPI = VideoAPIMock()
        viewModel = PlayerViewModel(
            video: Video(
                id: "1",
                title: "title",
                thumbnailUrl: "",
                embedUrl: ""
            ),
            api: mockAPI
        )
    }

    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        super.tearDown()
    }

    func testFetchMetadataSuccess() async {
        mockAPI.metadata = "https://test.com/embed_url"

        await viewModel.fetchMetadata()

        XCTAssertNil(viewModel.error)
        XCTAssertEqual(viewModel.videoURL, mockAPI.metadata!)
    }

    func testFetchMetadataFailure() async {
        mockAPI.metadata = nil

        await viewModel.fetchMetadata()

        XCTAssertNotNil(viewModel.error)
        XCTAssertTrue(viewModel.videoURL.isEmpty)
    }
}
