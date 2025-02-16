//
//  URLSessionMock.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 16/02/2025.
//

@testable import AZPlayer
import Foundation

class URLSessionMock: URLSessionProtocol {
    var data: Data?
    var error: Error?
    var statusCode: Int = 200

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let error = error {
            throw error
        }

        let response = HTTPURLResponse(
            url: url,
            statusCode: statusCode,
            httpVersion: nil,
            headerFields: nil
        )!

        return (data ?? Data(), response)
    }
}
