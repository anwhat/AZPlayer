//
//  VideosListViewModel.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

import Foundation
import SwiftUI

class VideosListViewModel: ObservableObject {
    @Published var videos: [Video] = []

    private let api: VideoAPIProtocol

    init(api: VideoAPIProtocol = VideoAPI()) {
        self.api = api
    }

    @MainActor
    func fetchVideos() async {
        videos = await api.fetchList()
    }
}
