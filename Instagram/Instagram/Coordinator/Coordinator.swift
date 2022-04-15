//
//  Coordinator.swift
//  Instagram
//
//  Created by Chung EXI-Nguyen on 4/9/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var children: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

class UnusedCoordinator: Coordinator {
    var children: [Coordinator] = []
    
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
    }
}
