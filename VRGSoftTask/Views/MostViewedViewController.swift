//
//  MostViewedViewController.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

class MostViewedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let mostViewedViewModel = MostViewedViewModel()
    var isLoadedData: Bool = false // Флаг, указывающий, загружены ли данные
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Убираем разделители у ячеек таблицы
        tableView.separatorStyle = .none
        
        // Регистрация XIB файла для ячейки
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
        
        navigationItem.title = "Most viewed articles"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mostViewedViewModel.getMostViewedArticles()
        bindViewModel()
    }
}
