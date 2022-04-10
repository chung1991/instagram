//
//  MainCoordinator.swift
//  Instagram
//
//  Created by Chung EXI-Nguyen on 4/9/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        guard let vc = HomeViewController.instantiate(from: "Main") else {
            return
        }
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    
}
