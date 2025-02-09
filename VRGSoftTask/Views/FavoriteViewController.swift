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
        navigationItem.title = "Favorite articles"
        
        viewModel.getFavoriteArticles()
        bindViewModel()
        
        tableView.separatorStyle = .none
        
        let nib = UINib(nibName: "ArticleTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ArticleTableViewCell")
    }
}
