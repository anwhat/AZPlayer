//
//  VideosListViewModelTests.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

@testable import AZPlayer
import XCTest

final class VideosListViewModelTests: XCTestCase {
    var viewModel: VideosListViewModel!
    var mockAPI: VideoAPIMock!

    override func setUp() {
        super.setUp()
        mockAPI = VideoAPIMock()
        viewModel = VideosListViewModel(api: mockAPI)
    }

    override func tearDown() {
        viewModel = nil
        mockAPI = nil
        super.tearDown()
    }

    func testFetchVideosSuccess() async {
        let mock = [
            Video(
                id: "1",
                title: "Video 1",
                thumbnail_url: "https://test.com/1.jpg",
                embed_url: "https://test.com/1"
            ),
            Video(
                id: "2",
                title: "Video 2",
                thumbnail_url: "https://test.com/2.jpg",
                embed_url: "https://test.com/2"
            )
        ]
        mockAPI.mockVideos = mock

        await viewModel.fetchVideos()

        XCTAssertEqual(viewModel.videos.count, mock.count)
        XCTAssertEqual(viewModel.videos.first?.title, "Video 1")
        XCTAssertEqual(viewModel.videos.last?.title, "Video 2")
    }

    func testFetchVideosFailure() async {
        mockAPI.mockVideos = []

        await viewModel.fetchVideos()

        XCTAssertTrue(viewModel.videos.isEmpty)
    }
}
