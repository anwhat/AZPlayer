//
//  ListVideos.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

struct ListVideos: Codable {
    let page: Int
    let limit: Int
    let total: Int
    let hasMore: Bool
    let list: [Video]

    enum CodingKeys: String, CodingKey {
        case page
        case limit
        case total
        case hasMore = "has_more"
        case list
    }
}
