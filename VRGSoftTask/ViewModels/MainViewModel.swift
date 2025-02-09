//
//  MainViewModel.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 08.02.2025.
//

import UIKit

class MainViewModel {
    var tableData: [MainTableData] {
        return [
            MainTableData(image: UIImage(systemName: "envelope.fill")!, titleText: "Most emailed",
                          descriptionText: "Displays the most shared articles via email.", screenID: "MostEmailedViewController"),
            MainTableData(image: UIImage(systemName: "square.and.arrow.up.fill")!, titleText: "Most shared",
                          descriptionText: "Highlights the most shared articles on social media.", screenID: "MostSharedViewController"),
            MainTableData(image: UIImage(systemName: "eye.fill")!, titleText: "Most viewed",
                          descriptionText: "Features articles with the highest page views.", screenID: "MostViewedViewController")
        ]
    }
    
    var favoriteData: MainTableData {
        return MainTableData(
            image: UIImage(systemName: "star.fill")!,
            titleText: "Favorite",
            descriptionText: "View and manage your saved articles for quick access.",
            screenID: "FavoriteViewController")
    }
}
