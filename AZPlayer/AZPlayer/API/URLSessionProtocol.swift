//
//  URLSessionProtocol.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 16/02/2025.
//

import Foundation

protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
