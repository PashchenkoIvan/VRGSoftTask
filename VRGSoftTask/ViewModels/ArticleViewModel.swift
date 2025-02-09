//
//  ArticleViewModel.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

class ArticleViewModel {
    var article: ArticleStruct
    
    init(article: ArticleStruct) {
        self.article = article
    }
    
    func getTitle() -> String {
        return article.title
    }
    
    func getAbstract() -> String {
        return article.abstract
    }
    
    func getPublishedDate() -> String {
        return article.publishedDate
    }
    
    func getImageUrls() -> [Media] {
        return article.media
    }
    
    func getAuthors() -> String {
        return article.byline
    }
    
    func getPublisher() -> String {
        return article.source
    }
    
    func getArticleURL() -> String {
        return article.url
    }
    
    func addToFavorite (article: ArticleStruct) {
        CoreDataManager.shared.addArticle(article)
    }
    
    func isFavoriteArticle (id: Int64) -> Bool {
        if CoreDataManager.shared.fetchArticle(id) != nil {
            return true
        } else {
            return false
        }
    }
    
    func removeFromFavorite (id: Int64) {
        CoreDataManager.shared.deleteArticle(with: id)
    }
}
