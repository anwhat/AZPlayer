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

    init(video: Video, api: VideoAPIProtocol = VideoAPI()) {
        self.video = video
        self.api = api
    }

    func fetchMetadata() async{
        guard let url = await api.fetchMetadata(id: video.id) else {
            // Handle error
            return
        }
        videoURL = url
    }
}
