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
}

class VideoAPI: VideoAPIProtocol, ObservableObject {
    private let session: URLSession

    @Published var videos: [Video] = []

    enum URLs: String {
        case fetchList

        var url: String {
            switch self {
                case .fetchList:
                    "https://api.dailymotion.com/user/alexis.landot/videos?fields=id,title,thumbnail_url,embed_url"
            }
        }
    }

    init(session: URLSession = .shared) {
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
}
