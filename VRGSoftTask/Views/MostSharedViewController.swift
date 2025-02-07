//
//  MostSharedViewController.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

class MostSharedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let mostSharedViewModel = MostSharedViewModel()
    var isLoadedData: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Убираем разделители у ячеек таблицы
        tableView.separatorStyle = .none
        
        // Регистрация XIB файла для ячейки
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Запускаем загрузку самых упоминаемых статей
        mostSharedViewModel.getMostSharedArticles()
        // Привязываем ViewModel к отображению
        bindViewModel()
    }
    
    //MARK: bindViewModel - Метод для привязки данных из ViewModel к представлению
    func bindViewModel() {
        mostSharedViewModel.mostShared.bind { [weak self] articles in
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

extension MostSharedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mostSharedViewModel.mostShared.value.isEmpty ? 1 : mostSharedViewModel.mostShared.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if mostSharedViewModel.mostShared.value.isEmpty {
            cell = UITableViewCell()
            cell.textLabel?.text = isLoadedData ? "No articles available" : "Loading articles..."
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
    
}
