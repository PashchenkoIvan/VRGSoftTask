//
//  Article.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 05.02.2025.
//

import Foundation

// MARK: - ArticleStruct
public struct ArticleStruct: Codable {
    let uri: String
    let url: String
    let id: Int64
    let assetID: Int64
    let source: String
    let publishedDate: String
    let updated: String
    let section: String
    let subsection: String
    let nytdsection: String
    let adxKeywords: String
    let column: String?
    let byline: String
    let type: String
    let title: String
    let abstract: String
    let desFacet: [String]
    let orgFacet: [String]
    let perFacet: [String]
    let geoFacet: [String]
    let media: [Media]
    let etaID: Int
    
    init(uri: String = "", url: String = "", id: Int64 = 0, assetID: Int64 = 0, source: String = "", publishedDate: String = "", updated: String = "", section: String = "", subsection: String = "", nytdsection: String = "", adxKeywords: String = "", column: String = "", byline: String = "", type: String = "", title: String = "", abstract: String = "", desFacet: [String] = [], orgFacet: [String] = [], perFacet: [String] = [], geoFacet: [String] = [], media: [Media] = [], etaID: Int = 0) {
        self.uri = uri
        self.url = url
        self.id = id
        self.assetID = assetID
        self.source = source
        self.publishedDate = publishedDate
        self.updated = updated
        self.section = section
        self.subsection = subsection
        self.nytdsection = nytdsection
        self.adxKeywords = adxKeywords
        self.column = column
        self.byline = byline
        self.type = type
        self.title = title
        self.abstract = abstract
        self.desFacet = desFacet
        self.orgFacet = orgFacet
        self.perFacet = perFacet
        self.geoFacet = geoFacet
        self.media = media
        self.etaID = etaID
    }
    
    enum CodingKeys: String, CodingKey {
        case uri
        case url
        case id
        case assetID = "asset_id"
        case source
        case publishedDate = "published_date"
        case updated
        case section
        case subsection
        case nytdsection
        case adxKeywords = "adx_keywords"
        case column
        case byline
        case type
        case title
        case abstract
        case desFacet = "des_facet"
        case orgFacet = "org_facet"
        case perFacet = "per_facet"
        case geoFacet = "geo_facet"
        case media
        case etaID = "eta_id"
    }
}
