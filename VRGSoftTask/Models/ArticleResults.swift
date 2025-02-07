//
//  ArticleResults.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 06.02.2025.
//

import Foundation

// MARK: - ArticleResultStruct
struct ArticleResultStruct: Codable {
    let status: String
    let copyright: String
    let numResults: Int
    let results: [ArticleStruct]
    
    init(status: String = "OK", copyright: String = "", numResults: Int = 0, results: [ArticleStruct] = []) {
        self.status = status
        self.copyright = copyright
        self.numResults = numResults
        self.results = results
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case copyright
        case numResults = "num_results"
        case results
    }
}
