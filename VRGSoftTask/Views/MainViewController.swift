//
//  MainViewController.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 08.02.2025.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var segmentBar: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var favoriteTableView: UITableView!
    
    let viewModel = MainViewModel()
    
    var isInternetAvailable = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        InternetConnectionManager.shared.startMonitoring()
        
    }
}
extension MainViewController: InternetConnectionManagerDelegate {
    func internetConnectionLost() {
        isInternetAvailable = false
        tableView.reloadData()
    }
}
