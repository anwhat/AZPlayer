//
//  Video.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 13/02/2025.
//

struct Video: Identifiable, Codable, Hashable {
    let id: String
    let title: String
    let thumbnailUrl: String
    let embedUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case thumbnailUrl = "thumbnail_url"
        case embedUrl = "embed_url"
    }
}
