//
//  MostViewed.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

extension MostViewedViewController {
    // MARK: - ViewModel Binding
    func bindViewModel() {
        mostViewedViewModel.mostViewed.bind { [weak self] articles in
            guard let self = self else { return }
            self.isLoadedData = true // Устанавливаем флаг загрузки данных
            
            DispatchQueue.main.async {
                self.tableView.reloadData() // Перезагрузка таблицы
            }
        }
    }
    
    func setupScreen () {
        // Убираем разделители у ячеек таблицы
        tableView.separatorStyle = .none
        
        // Регистрация XIB файла для ячейки
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
        
        navigationItem.title = "Most viewed articles"
    }
    
    // MARK: - Cell Configuration
    func configure(cell: ArticleTableViewCell, with article: ArticleStruct) {
        if let urlString = article.media.first?.mediaMetadata[article.media[0].mediaMetadata.count - 1].url,
           let url = URL(string: urlString) {
            cell.articleCellImageView.kf.setImage(with: url)
        }
        
        cell.articleCellTitleTextLabel.text = article.title
        cell.articleCellDescriptionTextLabel.text = article.abstract
        cell.selectionStyle = .none
    }
}

extension MostViewedViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mostViewedViewModel.mostViewed.value.isEmpty ? 1 : mostViewedViewModel.mostViewed.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mostViewedViewModel.mostViewed.value.isEmpty {
            return createEmptyStateCell(for: tableView)
        } else {
            return configureArticleCell(for: tableView, at: indexPath)
        }
    }
    
    private func createEmptyStateCell(for tableView: UITableView) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = isLoadedData ? "No articles available" : "Loading articles..."
        cell.textLabel?.textAlignment = .center // Центрируем текст
        return cell
    }
    
    private func configureArticleCell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        let currentArticle = mostViewedViewModel.mostViewed.value[indexPath.row]
        configure(cell: cell, with: currentArticle)
        return cell
    }
}

extension MostViewedViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = mostViewedViewModel.mostViewed.value[indexPath.row]
        let articleViewModel = ArticleViewModel(article: selectedArticle)
        
        let articleVC = instantiateArticleViewController()
        articleVC.viewModel = articleViewModel
        
        navigationController?.pushViewController(articleVC, animated: true)
    }
    
    private func instantiateArticleViewController() -> ArticleViewController {
        return storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
    }
}
