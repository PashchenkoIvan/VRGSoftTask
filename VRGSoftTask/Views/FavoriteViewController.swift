//
//  FavoriteViewController.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 07.02.2025.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FavoriteViewModel()
    var isLoadedData = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.getFavoriteArticles()
        bindViewModel()
    }
}
