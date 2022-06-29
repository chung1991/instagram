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
    
    func pushViewController(_ vc: UIViewController) {
        guard let navigationController = rootViewController as? UINavigationController else {
            return
        }
        navigationController.pushViewController(vc, animated: true)
    }
}

extension MainCoordinator: PostListVCDelegate {
    func didTapPhotoDetails(_ userPost: UserPost) {
        let photoListVc = PhotoListVC()
        photoListVc.configure(userPost)
        pushViewController(photoListVc)
    }
}
