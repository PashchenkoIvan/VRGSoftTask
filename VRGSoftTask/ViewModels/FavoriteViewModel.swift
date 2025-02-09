//
//  FavoriteViewModel.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 08.02.2025.
//

import Foundation

class FavoriteViewModel {
    var favoriteArticles: [Article] = []
    
    func getFavoriteArticles () {
        self.favoriteArticles = CoreDataManager.shared.fetchArticles()
    }
    
    func deleteFromFavorite (_ id: Int64) {
        CoreDataManager.shared.deleteArticle(with: id)
    }
}
