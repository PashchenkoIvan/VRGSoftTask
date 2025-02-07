//
//  MediaMetaData.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 05.02.2025.
//

import Foundation

// MARK: - MediaMetadatum
struct MediaMetadatum: Codable {
    let url: String
    let format: String
    let height: Int
    let width: Int
    
    init(url: String = "", format: String = "", height: Int = 0, width: Int = 0) {
        self.url = url
        self.format = format
        self.height = height
        self.width = width
    }
    
    enum CodingKeys: String, CodingKey {
        case url
        case format
        case height
        case width
    }
}
