//
//  Main.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 09.02.2025.
//

import UIKit

extension MainViewController {
    func setupScreen () {
        InternetConnectionManager.shared.delegate = self
        
        let cornerRadius: CGFloat = 10
        tableView.layer.cornerRadius = cornerRadius
        tableView.layer.masksToBounds = true
        tableView.isScrollEnabled = false
        
        favoriteTableView.layer.cornerRadius = cornerRadius
        favoriteTableView.layer.masksToBounds = true
        favoriteTableView.isScrollEnabled = false
        
        // Регистрация XIB файла для ячейки
        let nib = UINib(nibName: "MainTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
        favoriteTableView.register(nib, forCellReuseIdentifier: "MainTableViewCell")
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        // Установка периода в зависимости от выбранного сегмента
        switch sender.selectedSegmentIndex {
        case 0: RequestFactory.setPeriod(period: .day)
        case 1: RequestFactory.setPeriod(period: .week)
        case 2: RequestFactory.setPeriod(period: .month)
        default: RequestFactory.setPeriod(period: .month)
        }
    }
}

// MARK: - UITableViewDataSource
extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableView == self.tableView ? viewModel.tableData.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
                return UITableViewCell()
            }
            
            // Настройка ячейки для основного таблицы
            let data = viewModel.tableData[indexPath.row]
            cell.mainTableImageView.image = data.image
            cell.mainTableTextTitle.text = data.titleText
            cell.mainTableDescriptionTitle.text = data.descriptionText
            
            if !isInternetAvailable {
                cell.backgroundColor = UIColor.lightGray
                cell.mainTableTextTitle?.textColor = UIColor.darkGray
                cell.mainTableDescriptionTitle?.textColor = UIColor.darkGray
            }
            
            return cell
        } else if tableView == self.favoriteTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as? MainTableViewCell else {
                return UITableViewCell()
            }
            
            // Настройка ячейки для таблицы избранного
            cell.mainTableImageView.image = viewModel.favoriteData.image
            cell.mainTableTextTitle.text = viewModel.favoriteData.titleText
            cell.mainTableDescriptionTitle.text = viewModel.favoriteData.descriptionText
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var screenID: String = ""
        
        // Определение ID экрана для перехода
        if tableView == self.tableView {
            if isInternetAvailable {
                screenID = viewModel.tableData[indexPath.row].screenID
            }
        } else if tableView == self.favoriteTableView {
            screenID = viewModel.favoriteData.screenID
        } else {
            return // Ничего не делаем, если ничего не выбрано
        }
        
        if screenID != "" {
            // Инициализация контроллера из Storyboard
            if let viewController = storyboard?.instantiateViewController(withIdentifier: screenID) {
                // Переход на нужный экран
                navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        // Убираем выделение
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

