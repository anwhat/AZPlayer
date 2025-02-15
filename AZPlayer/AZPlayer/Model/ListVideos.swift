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
    let has_more: Bool
    let list: [Video]
}
