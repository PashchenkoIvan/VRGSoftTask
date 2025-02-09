//
//  ArticleViewController.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit
import Kingfisher

class ArticleViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourseLabel: UILabel!
    @IBOutlet weak var bylineLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!
    
    var viewModel: ArticleViewModel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        titleLabel.text = viewModel.getTitle()
        sourseLabel.text = viewModel.getPublisher()
        bylineLabel.text = viewModel.getAuthors()
        descriptionLabel.text = viewModel.getAbstract()
        urlLabel.text = "Article url: \(viewModel.getArticleURL())"
        dateLabel.text = viewModel.getPublishedDate()
        
        let url = URL(string: viewModel.article.media[0].mediaMetadata[2].url)
        articleImageView.kf.setImage(with: url)
        
        self.navigationItem.title = viewModel.getTitle()
        
        setupNavigationBarButton()
    }
    
    func setupNavigationBarButton() {
        let starButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(starButtonTapped))
        navigationItem.rightBarButtonItem = starButton
    }
    
    @objc func starButtonTapped() {
        print(viewModel.article)
        
        viewModel.addToFavorite(article: viewModel.article)
        
        UIView.animate(withDuration: 0.3) {
            self.navigationItem.rightBarButtonItem?.customView?.alpha = 0
            self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
        }
        self.navigationItem.rightBarButtonItem?.customView?.isHidden = true
    }
}
