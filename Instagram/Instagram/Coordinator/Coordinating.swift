//
//  Coordinating.swift
//  Instagram
//
//  Created by Chung EXI-Nguyen on 4/9/22.
//

import Foundation
import UIKit

protocol Coordinating {
    var coordinator: Coordinator! { get set }
    static func instantiate(from storyboard: String) -> Self?
}

extension Coordinating where Self: UIViewController {
    static func instantiate(from storyboard: String) -> Self? {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboard, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: id) as? Self
    }
}
