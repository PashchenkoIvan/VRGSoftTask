//
//  MostEmailed.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

extension MostEmailedViewController {
    //MARK: bindViewModel - Метод для привязки данных из ViewModel к представлению
    func bindViewModel() {
        mostEmailedViewModel.mostEmailed.bind { [weak self] articles in
            self?.isLoadedData = true // Устанавливаем флаг, что данные загружены
            
            DispatchQueue.main.async {
                // Перезагружаем таблицу для отображения новых данных
                self?.tableView.reloadData()
            }
        }
    }
    
    //MARK: configure - Метод для настройки ячейки с данными статьи
    func configure(cell: ArticleTableViewCell, with article: ArticleStruct) {
        cell.titleTextLabel.text = article.title
        cell.descriptionTextLabel.text = article.abstract
        cell.selectionStyle = .none
    }
}

// MARK: - UITableViewDataSource methods
extension MostEmailedViewController: UITableViewDataSource {
    // Указываем количество строк в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Если данных нет, возвращаем 1 ( для отображения сообщения)
        return mostEmailedViewModel.mostEmailed.value.isEmpty ? 1 : mostEmailedViewModel.mostEmailed.value.count
    }
    
    // Настройка ячейки для отображения
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if mostEmailedViewModel.mostEmailed.value.isEmpty {
            // Если данных нет, создаем ячейку с сообщением
            cell = UITableViewCell()
            cell.textLabel?.text = isLoadedData ? "No articles available" : "Loading articles..."
        } else {
            // Получаем текущую статью
            let currentArticle = mostEmailedViewModel.mostEmailed.value[indexPath.row]
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

extension MostEmailedViewController: UITableViewDelegate {
    // Можно добавить дополнительные методы делегата здесь, если это необходимо.
}
