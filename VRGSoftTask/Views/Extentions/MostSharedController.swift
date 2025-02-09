//
//  MostShared.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

extension MostSharedViewController {
    
    // Метод для привязки данных из ViewModel к представлению
    func bindViewModel() {
        mostSharedViewModel.mostShared.bind { [weak self] articles in
            self?.isLoadedData = true
            
            DispatchQueue.main.async {
                // Перезагружаем таблицу для отображения новых данных
                self?.tableView.reloadData()
            }
        }
    }
    
    // Метод для настройки ячейки с данными статьи
    func configure(cell: ArticleTableViewCell, with article: ArticleStruct) {
        let urlString = article.media[0].mediaMetadata[1].url
        let url = URL(string: urlString)
        cell.articleCellImageView.kf.setImage(with: url)
        
        cell.articleCellTitleTextLabel.text = article.title
        cell.articleCellDescriptionTextLabel.text = article.abstract
        cell.selectionStyle = .none
    }
}

extension MostSharedViewController: UITableViewDataSource {
    
    // Указываем количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Если данных нет, возвращаем 1 (для отображения сообщения)
        return mostSharedViewModel.mostShared.value.isEmpty ? 1 : mostSharedViewModel.mostShared.value.count
    }
    
    // Настройка ячейки для отображения
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if mostSharedViewModel.mostShared.value.isEmpty {
            // Если данных нет, создаем ячейку с сообщением
            cell = UITableViewCell()
            cell.textLabel?.text = isLoadedData ? "No articles available" : "Loading articles..."
            cell.textLabel?.textAlignment = .center // Центрируем текст
        } else {
            // Получаем текущую статью
            let currentArticle = mostSharedViewModel.mostShared.value[indexPath.row]
            // Декьюдим ячейку типа ArticleTableViewCell
            guard let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
                return UITableViewCell() // Возвращаем пустую ячейку в случае ошибки
            }
            // Конфигурируем ячейку с данными статьи
            configure(cell: articleCell, with: currentArticle)
            cell = articleCell // Устанавливаем текущую ячейку
        }
        return cell // Возвращаем ячейку
    }
}

extension MostSharedViewController: UITableViewDelegate {
    
    // Метод для обработки нажатия на ячейку
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedArticle = mostSharedViewModel.mostShared.value[indexPath.row]
        let articleViewModel = ArticleViewModel(article: selectedArticle)
        
        // Создание экземпляра ArticleViewController из storyboard
        let articleVC = storyboard?.instantiateViewController(withIdentifier: "ArticleViewController") as! ArticleViewController
        articleVC.viewModel = articleViewModel
        
        // Переход к экрану статьи
        navigationController?.pushViewController(articleVC, animated: true)
    }
}
