//
//  StorageManager.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 08.02.2025.
//

import UIKit
import CoreData

public final class CoreDataManager: NSObject {
    public static let shared = CoreDataManager()
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func addArticle(_ articleStruct: ArticleStruct) {
        if fetchArticle(articleStruct.id) != nil {
            print("Article with id \(articleStruct.id) already exists. Not adding.")
            return
        }
        
        let _ = Article.fromArticleStruct(articleStruct, context: context)
        
        do {
            try context.save()
            print("Article with id \(articleStruct.id) added successfully.")
        } catch {
            print("Failed to save article: \(error.localizedDescription)")
        }
    }
    
    public func fetchArticles() -> [Article] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {
            return (try? context.fetch(fetchRequest) as? [Article]) ?? []
        }
    }
    
    public func fetchArticle(_ id: Int64) -> Article? {
        let fetchRequest = NSFetchRequest<Article>(entityName: "Article")
        do {
            let articles = try? context.fetch(fetchRequest) as? [Article]
            return articles?.first(where: { $0.id == id })
        } catch {
            print("Error fetching article: \(error.localizedDescription)")
            return nil
        }
    }
    
    public func deleteArticle(with id: Int64) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        do {
            guard let articles = try? context.fetch(fetchRequest) as? [Article],
                  let article = articles.first(where: { $0.id == id }) else { return }
            context.delete(article)
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteAllArticles() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        fetchRequest.includesPropertyValues = false
        do {
            let articles = try context.fetch(fetchRequest) as! [NSManagedObject]
            for article in articles {
                context.delete(article)
            }
            appDelegate.saveContext()
        } catch {
            print("Failed to delete articles: \(error.localizedDescription)")
        }
    }
}
