//
//  VideoAPI.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

import Combine
import Foundation

class VideoAPI: ObservableObject {
    @Published var videos: [Video] = []

    func fetchList() async {
        guard let url = URL(string: "https://api.dailymotion.com/user/alexis.landot/videos?fields=id,title,thumbnail_url,embed_url") else { return }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let list = try JSONDecoder().decode(ListVideos.self, from: data)
            videos = list.list
        } catch {
            print("Error fetching videos: \(error.localizedDescription)")
        }
    }
}
