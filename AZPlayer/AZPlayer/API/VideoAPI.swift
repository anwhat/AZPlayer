//
//  VideoAPI.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

import Combine
import Foundation

protocol VideoAPIProtocol {
    func fetchList() async -> [Video]
    func fetchMetadata(id: String) async -> String?
}

class VideoAPI: VideoAPIProtocol, ObservableObject {
    private let session: URLSessionProtocol

    @Published var videos: [Video] = []

    enum URLs: String {
        case fetchList
        case fetchMetadata

        var url: String {
            switch self {
                case .fetchList:
                    "https://api.dailymotion.com/user/alexis.landot/videos?fields=id,title,thumbnail_url,embed_url"
                case .fetchMetadata:
                    "https://www.dailymotion.com/player/metadata/video/x9d9k6k/@{id}"
            }
        }
    }

    init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    func fetchList() async -> [Video] {
        guard let url = URL(string: URLs.fetchList.url) else { return  [] }

        do {
            let (data, _) = try await session.data(from: url)
            let list = try JSONDecoder().decode(ListVideos.self, from: data)
            return list.list
        } catch {
            print("Error fetching videos: \(error.localizedDescription)")
            return []
        }
    }

    func fetchMetadata(id: String) async -> String? {
        guard let url = URL(string: URLs.fetchMetadata.url.replacingOccurrences(of: "@{id}", with: id)) else {
            return nil
        }

        do {
            let (data, _) = try await session.data(from: url)
            let metadata = try JSONDecoder().decode(VideoMetadata.self, from: data)
            return metadata.url
        } catch {
            print("Error fetching metadata: \(error.localizedDescription)")
            return nil
        }
    }
}
