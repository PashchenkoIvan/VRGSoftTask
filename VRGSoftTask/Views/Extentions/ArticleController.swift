//
//  Article.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 09.02.2025.
//

import UIKit

extension ArticleViewController {
    func setupScreen () {
        titleLabel.text = viewModel.getTitle()
        sourseLabel.text = viewModel.getPublisher()
        bylineLabel.text = viewModel.getAuthors()
        descriptionLabel.text = viewModel.getAbstract()
        urlLabel.text = "Article url: \(viewModel.getArticleURL())"
        dateLabel.text = viewModel.getPublishedDate()
        
        let url = URL(string: viewModel.article.media[0].mediaMetadata[viewModel.article.media[0].mediaMetadata.count - 1].url)
        articleImageView.kf.setImage(with: url)
        
        self.navigationItem.title = viewModel.getTitle()
        
        setupNavigationBarButton()
    }
    
    func setupNavigationBarButton() {
        if !viewModel.isFavoriteArticle(id: viewModel.article.id) {
            let starButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(addFavoriteButtonTapped))
            navigationItem.rightBarButtonItem = starButton
        } else {
            let fillStarButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(removeFavoriteButtonTapped))
            navigationItem.rightBarButtonItem = fillStarButton
        }
    }
    
    @objc func addFavoriteButtonTapped() {
        viewModel.addToFavorite(article: viewModel.article)
        
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.rightBarButtonItem?.customView?.alpha = 0
            self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
        }
        self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
        
        viewWillAppear(true)
    }
    
    @objc func removeFavoriteButtonTapped() {
        viewModel.removeFromFavorite(id: viewModel.article.id)
        
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.rightBarButtonItem?.customView?.alpha = 0
            self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
        }
        self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
        
        viewWillAppear(true)
    }
}
