//
//  MainCoordinator.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/26/22.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var subCoordinators: [Coordinator] = []
    var rootViewController: UIViewController
    init(_ rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
}
