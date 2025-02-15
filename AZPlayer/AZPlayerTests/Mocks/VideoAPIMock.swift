//
//  VideoAPIMock.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

@testable import AZPlayer

class VideoAPIMock: VideoAPIProtocol {
    var mockVideos: [Video] = []
    var mockMetadata: String? = nil

    func fetchList() async -> [Video] {
        mockVideos
    }

    func fetchMetadata(id: String) async -> String? {
        mockMetadata
    }
}
