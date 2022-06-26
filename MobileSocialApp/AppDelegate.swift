//
//  AppDelegate.swift
//  MobileSocialApp
//
//  Created by Chung EXI-Nguyen on 6/19/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var mainCoordinator: Coordinator!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        mainCoordinator = MainCoordinator(PostListVC())
        window?.rootViewController = mainCoordinator.rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

