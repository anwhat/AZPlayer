//
//  PlayerViewModel.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

import SwiftUI

class PlayerViewModel: ObservableObject {
    private let video: Video
    private let api: VideoAPIProtocol

    @Published var videoURL: String = ""
    @Published var isPlaying: Bool = false
    @Published var seekPosition = 0.0
    @Published var error: String? = nil

    init(video: Video, api: VideoAPIProtocol = VideoAPI()) {
        self.video = video
        self.api = api
    }

    @MainActor
    func fetchMetadata() async {
        guard let url = await api.fetchMetadata(id: video.id) else {
            error = "Error while fetching video"
            return
        }
        videoURL = url
    }
}
