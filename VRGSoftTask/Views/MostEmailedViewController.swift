//
//  ViewController.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 05.02.2025.
//

import UIKit

class MostEmailedViewController: UIViewController {
    
    //MARK: IBOutlet для таблицы
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Модель для получения данных о самых упоминаемых статьях
    let mostEmailedViewModel = MostEmailedViewModel()
    var isLoadedData: Bool = false // Флаг, указывающий, загружены ли данные
    
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
        mostEmailedViewModel.getMostEmailedArticles()
        // Привязываем ViewModel к отображению
        bindViewModel()
    }
}
