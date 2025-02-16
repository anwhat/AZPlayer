//
//  VideoAPIMock.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

@testable import AZPlayer

class VideoAPIMock: VideoAPIProtocol {
    var videos: [Video] = []
    var metadata: String? = nil

    func fetchList() async -> [Video] {
        videos
    }

    func fetchMetadata(id: String) async -> String? {
        metadata
    }
}
