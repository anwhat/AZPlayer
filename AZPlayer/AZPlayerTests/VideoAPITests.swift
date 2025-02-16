//
//  VideoAPITests.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 16/02/2025.
//

@testable import AZPlayer
import XCTest

class VideoAPITests: XCTestCase {
    var sut: VideoAPI!
    var mockSession: URLSessionMock!

    override func setUp() {
        super.setUp()
        mockSession = URLSessionMock()
        sut = VideoAPI(session: mockSession)
    }

    override func tearDown() {
        sut = nil
        mockSession = nil
        super.tearDown()
    }

    func testFetchListURL() {
        XCTAssertEqual(
            VideoAPI.URLs.fetchList.url,
            "https://api.dailymotion.com/user/alexis.landot/videos?fields=id,title,thumbnail_url,embed_url"
        )
    }

    func testFetchMetadataURL() {
        XCTAssertEqual(
            VideoAPI.URLs.fetchMetadata.url,
            "https://www.dailymotion.com/player/metadata/video/x9d9k6k/@{id}"
        )
    }

    func testFetchListSuccess() async {
        mockSession.data = """
        {
            "page": 1,
            "limit": 10,
            "total": 32,
            "has_more": true,
            "list": [
                {
                    "id": "x9d9k6k",
                    "title": "Video",
                    "thumbnail_url": "https://test.com/thumbnail.jpg",
                    "embed_url": "https://test.com/embed"
                }
            ]
        }
        """.data(using: .utf8)

        let videos = await sut.fetchList()

        XCTAssertEqual(videos.count, 1)
        XCTAssertEqual(videos.first?.id, "x9d9k6k")
        XCTAssertEqual(videos.first?.title, "Video")
        XCTAssertEqual(videos.first?.thumbnailUrl, "https://test.com/thumbnail.jpg")
        XCTAssertEqual(videos.first?.embedUrl, "https://test.com/embed")
    }

    func testFetchListNetworkError() async {
        mockSession.error = NSError(domain: "error", code: -1, userInfo: nil)

        let videos = await sut.fetchList()

        XCTAssertTrue(videos.isEmpty)
    }

    func testFetchMetadataSuccess() async {
        mockSession.data =
        """
        {
            "qualities": {
                "auto": [
                    {
                        "url": "https://test.com/video"
                    }
                ]
            }
        }
        """.data(using: .utf8)

        let url = await sut.fetchMetadata(id: "1")

        XCTAssertEqual(url, "https://test.com/video")
    }

    func testFetchMetadataNetworkError() async {
        mockSession.error = NSError(domain: "error", code: -1, userInfo: nil)

        let url = await sut.fetchMetadata(id: "1")

        XCTAssertNil(url)
    }
}
