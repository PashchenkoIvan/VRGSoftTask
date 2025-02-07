//
//  Media.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 05.02.2025.
//

import Foundation

// MARK: - Media
struct Media: Codable {
    let type: String
    let subtype: String
    let caption: String
    let copyright: String
    let approvedForSyndication: Int
    let mediaMetadata: [MediaMetadatum]
    
    init(type: String = "", subtype: String = "", caption: String = "", copyright: String = "", approvedForSyndication: Int = 0, mediaMetadata: [MediaMetadatum] = []) {
        self.type = type
        self.subtype = subtype
        self.caption = caption
        self.copyright = copyright
        self.approvedForSyndication = approvedForSyndication
        self.mediaMetadata = mediaMetadata
    }
    
    enum CodingKeys: String, CodingKey {
        case type
        case subtype
        case caption
        case copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}
