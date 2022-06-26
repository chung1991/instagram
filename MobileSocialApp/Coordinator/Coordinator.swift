//
//  Coordinator.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/26/22.
//

import Foundation
import UIKit

protocol Coordinator {
    var subCoordinators: [Coordinator] { get set }
    var rootViewController: UIViewController { get set }
}
