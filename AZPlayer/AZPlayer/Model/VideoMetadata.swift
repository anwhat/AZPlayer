//
//  VideoMetadata.swift
//  AZPlayer
//
//  Created by Anouar Zemouri on 15/02/2025.
//

struct VideoMetadata: Decodable {
    let url: String

    enum CodingKeys: String, CodingKey {
        case qualities
        case auto
        case url
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let qualities = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .qualities)
        var autoArray = try qualities.nestedUnkeyedContainer(forKey: .auto)
        let firstAuto = try autoArray.nestedContainer(keyedBy: CodingKeys.self)
        url = try firstAuto.decode(String.self, forKey: .url)
    }
}

