//
//  InternetConnectionManager.swift
//  VRGSoftTask
//
//  Created by Пащенко Иван on 09.02.2025.
//

import UIKit
import Network

protocol InternetConnectionManagerDelegate: AnyObject {
    func internetConnectionLost()
}

class InternetConnectionManager {
    
    static let shared = InternetConnectionManager()
    
    private var monitor: NWPathMonitor
    weak var delegate: InternetConnectionManagerDelegate?
    
    private init() {
        monitor = NWPathMonitor()
        DispatchQueue.global().async {
            self.startMonitoring()
        }
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            if path.status == .unsatisfied {
                DispatchQueue.main.async {
                    self.delegate?.internetConnectionLost()
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
    
    deinit {
        monitor.cancel()
    }
    
    private func noInternetConnection() {
        let mainViewController = MainViewController()
        mainViewController.viewWillAppear(true)
    }
}
