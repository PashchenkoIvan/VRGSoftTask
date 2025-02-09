//
//  Favorite.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 08.02.2025.
//

import UIKit

extension FavoriteViewController {
    func bindViewModel() {
        isLoadedData = true
        tableView.reloadData()
    }
    
    func configure(cell: ArticleTableViewCell, with article: ArticleStruct) {
        let urlString = article.media[0].mediaMetadata[0].url
        let url = URL(string: urlString)
        cell.articleCellImageView.kf.setImage(with: url)
        
        cell.articleCellTitleTextLabel.text = article.title
        cell.articleCellDescriptionTextLabel.text = article.abstract
        cell.selectionStyle = .none
    }
}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favoriteArticles.isEmpty ? 1 : viewModel.favoriteArticles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.favoriteArticles.isEmpty {
            let cell = UITableViewCell()
            cell.textLabel?.text = isLoadedData ? "No articles available" : "Loading articles..."
            cell.textLabel?.textAlignment = .center
            return cell
        } else {
            let currentArticle = viewModel.favoriteArticles[indexPath.row]
            guard let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
                return UITableViewCell()
            }
            configure(cell: articleCell, with: currentArticle.toArticleStruct())
            return articleCell
        }
    }
}

extension FavoriteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let articleID = viewModel.favoriteArticles[indexPath.row].id
            viewModel.deleteFromFavorite(articleID)

            viewModel.getFavoriteArticles()
            tableView.reloadData()
            
            if viewModel.favoriteArticles.isEmpty {
                print("No articles available.")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = viewModel.favoriteArticles[indexPath.row]
        
        let articleViewModel = ArticleViewModel(article: selectedArticle.toArticleStruct())
        let articleVC = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        
        articleVC.viewModel = articleViewModel
        
        navigationController?.pushViewController(articleVC, animated: true)
    }
}
