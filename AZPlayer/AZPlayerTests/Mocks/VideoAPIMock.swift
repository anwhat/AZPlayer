//
//  VideoAPIMock.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

@testable import AZPlayer

class VideoAPIMock: VideoAPIProtocol {
    var mockVideos: [Video] = []

    func fetchList() async -> [Video] {
        mockVideos
    }
}
