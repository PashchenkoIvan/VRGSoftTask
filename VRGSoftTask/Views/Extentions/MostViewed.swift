//
//  MostViewed.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

extension MostViewedViewController {
    //MARK: bindViewModel - Метод для привязки данных из ViewModel к представлению
    func bindViewModel() {
        mostViewedViewModel.mostViewed.bind { [weak self] articles in
            self?.isLoadedData = true // Устанавливаем флаг, что данные загружены
            
            DispatchQueue.main.async {
                // Перезагружаем таблицу для отображения новых данных
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: configure - Метод для настройки ячейки с данными статьи
    private func configure(cell: ArticleTableViewCell, with article: ArticleStruct) {
        cell.titleTextLabel.text = article.title
        cell.descriptionTextLabel.text = article.abstract
        cell.selectionStyle = .none
    }
}

extension MostViewedViewController: UITableViewDataSource {
    // Указываем количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Если данных нет, возвращаем 1 ( для отображения сообщения)
        return mostViewedViewModel.mostViewed.value.isEmpty ? 1 : mostViewedViewModel.mostViewed.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if mostViewedViewModel.mostViewed.value.isEmpty {
            // Если данных нет, создаем ячейку с сообщением
            cell = UITableViewCell()
            cell.textLabel?.text = isLoadedData ? "No articles available" : "Loading articles..."
        } else {
            // Получаем текущую статью
            let currentArticle = mostViewedViewModel.mostViewed.value[indexPath.row]
            // Декьюдим ячейку типа ArticleTableViewCell
            guard let articleCell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
                return UITableViewCell()
            }
            // Конфигурируем ячейку с данными статьи
            configure(cell: articleCell, with: currentArticle)
            cell = articleCell // Устанавливаем текущую ячейку
        }
        return cell // Возвращаем ячейку
    }
}

extension MostViewedViewController: UITableViewDelegate {
    
}

