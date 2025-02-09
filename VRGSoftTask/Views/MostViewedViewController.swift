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
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mostViewedViewModel.getMostViewedArticles()
        bindViewModel()
    }
}
