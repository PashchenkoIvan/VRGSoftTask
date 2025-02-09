//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Пащенко Иван on 08.02.2025.
//
//

import Foundation
import CoreData

@objc(Article)
public class Article: NSManagedObject {}

extension Article {
    @NSManaged public var uri: String?
    @NSManaged public var url: String?
    @NSManaged public var id: Int64
    @NSManaged public var assetID: Int64
    @NSManaged public var source: String?
    @NSManaged public var publishedDate: String?
    @NSManaged public var update: String?
    @NSManaged public var section: String?
    @NSManaged public var subsection: String?
    @NSManaged public var nytdsection: String?
    @NSManaged public var adxKeywords: String?
    @NSManaged public var column: String?
    @NSManaged public var byline: String?
    @NSManaged public var type: String?
    @NSManaged public var title: String?
    @NSManaged public var abstract: String?
    @NSManaged public var desFacet: [String]?
    @NSManaged public var orgFacet: [String]?
    @NSManaged public var perFacet: [String]?
    @NSManaged public var geoFacet: [String]?
    @NSManaged public var media: NSObject?
    @NSManaged public var etaID: Int64
}

extension Article {
    func toArticleStruct() -> ArticleStruct {
        let mediaItems: [Media] = {
            guard let mediaData = self.media as? Data else { return [] }
            return (try? JSONDecoder().decode([Media].self, from: mediaData)) ?? []
        }()
        
        return ArticleStruct(
            uri: self.uri ?? "",
            url: self.url ?? "",
            id: self.id,
            assetID: self.assetID,
            source: self.source ?? "",
            publishedDate: self.publishedDate ?? "",
            updated: self.update ?? "",
            section: self.section ?? "",
            subsection: self.subsection ?? "",
            nytdsection: self.nytdsection ?? "",
            adxKeywords: self.adxKeywords ?? "",
            column: self.column ?? "",
            byline: self.byline ?? "",
            type: self.type ?? "",
            title: self.title ?? "",
            abstract: self.abstract ?? "",
            desFacet: self.desFacet ?? [],
            orgFacet: self.orgFacet ?? [],
            perFacet: self.perFacet ?? [],
            geoFacet: self.geoFacet ?? [],
            media: mediaItems,
            etaID: Int(self.etaID)
        )
    }
    
    @discardableResult
    static func fromArticleStruct(_ articleStruct: ArticleStruct, context: NSManagedObjectContext) -> Article {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Article", in: context) else {
            fatalError("Could not find entity description for Article.")
        }
        
        let article = Article(entity: entityDescription, insertInto: context)
        article.uri = articleStruct.uri
        article.url = articleStruct.url
        article.id = articleStruct.id
        article.assetID = articleStruct.assetID
        article.source = articleStruct.source
        article.publishedDate = articleStruct.publishedDate
        article.update = articleStruct.updated
        article.section = articleStruct.section
        article.subsection = articleStruct.subsection
        article.nytdsection = articleStruct.nytdsection
        article.adxKeywords = articleStruct.adxKeywords
        article.column = articleStruct.column
        article.byline = articleStruct.byline
        article.type = articleStruct.type
        article.title = articleStruct.title
        article.abstract = articleStruct.abstract
        article.desFacet = articleStruct.desFacet
        article.orgFacet = articleStruct.orgFacet
        article.perFacet = articleStruct.perFacet
        article.geoFacet = articleStruct.geoFacet
        
        if let mediaData = try? JSONEncoder().encode(articleStruct.media) {
            article.media = mediaData as NSObject
        }
        
        article.etaID = Int64(articleStruct.etaID)
        
        return article
    }
}
