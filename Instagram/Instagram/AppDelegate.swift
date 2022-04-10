//
//  AppDelegate.swift
//  Instagram
//
//  Created by Chung EXI-Nguyen on 4/9/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var coordinator: Coordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let nvc = UINavigationController()
        coordinator = MainCoordinator(navigationController: nvc)
        window?.rootViewController = nvc
        coordinator?.start()
        return true
    }

}

