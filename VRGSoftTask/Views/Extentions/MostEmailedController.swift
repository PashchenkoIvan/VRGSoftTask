//
//  MostEmailed.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

extension MostEmailedViewController {
    // Метод для привязки данных из ViewModel к представлению
    func bindViewModel() {
        mostEmailedViewModel.mostEmailed.bind { [weak self] articles in
            self?.isLoadedData = true
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func setupScreen () {
        // Убираем разделители у ячеек таблицы
        tableView.separatorStyle = .none
        
        // Регистрация XIB файла для ячейки
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
        
        navigationItem.title = "Most emailed articles"
    }
    
    // Метод для настройки ячейки с данными статьи
    func configure(cell: ArticleTableViewCell, with article: ArticleStruct) {
        let urlString = article.media[0].mediaMetadata[article.media[0].mediaMetadata.count - 1].url
        let url = URL(string: urlString)
        cell.articleCellImageView.kf.setImage(with: url)
        
        cell.articleCellTitleTextLabel.text = article.title
        cell.articleCellDescriptionTextLabel.text = article.abstract
        cell.selectionStyle = .none
    }
}

extension MostEmailedViewController: UITableViewDataSource {
    
    // Указываем количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Если данных нет, возвращаем 1 для отображения сообщения об отсутствии статей
        return mostEmailedViewModel.mostEmailed.value.isEmpty ? 1 : mostEmailedViewModel.mostEmailed.value.count
    }
    
    // Настройка ячейки для отображения
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if mostEmailedViewModel.mostEmailed.value.isEmpty {
            // Если данных нет, создаем ячейку с сообщением
            let cell = UITableViewCell()
            cell.textLabel?.text = isLoadedData ? "No articles available" : "Loading articles..."
            cell.textLabel?.textAlignment = .center
            return cell
        }
        
        // Получаем текущую статью
        let currentArticle = mostEmailedViewModel.mostEmailed.value[indexPath.row]
        guard let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        // Конфигурируем ячейку с данными статьи
        configure(cell: articleCell, with: currentArticle)
        return articleCell
    }
}

extension MostEmailedViewController: UITableViewDelegate {
    
    // Метод для обработки нажатия на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = mostEmailedViewModel.mostEmailed.value[indexPath.row]
        let articleViewModel = ArticleViewModel(article: selectedArticle)
        
        let articleVC = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        articleVC.viewModel = articleViewModel
        
        navigationController?.pushViewController(articleVC, animated: true)
    }
}
