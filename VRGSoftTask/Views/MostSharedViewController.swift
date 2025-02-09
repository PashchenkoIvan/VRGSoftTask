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
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // Запускаем загрузку самых упоминаемых статей
        mostSharedViewModel.getMostSharedArticles()
        // Привязываем ViewModel к отображению
        bindViewModel()
    }
}
