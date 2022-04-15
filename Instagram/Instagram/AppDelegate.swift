//
//  AppDelegate.swift
//  Instagram
//
//  Created by Chung EXI-Nguyen on 4/9/22.
//

import UIKit
import Logging

let logger = Logger(label: Bundle.main.bundleIdentifier ?? "Default Logger")

func isRunningUnitTests() -> Bool {
    let env = ProcessInfo.processInfo.environment
    if let injectBundle = env["XCTestBundlePath"] {
        return NSString(string: injectBundle).pathExtension == "xctest"
    }
    return false
}

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    lazy var coordinator: Coordinator = injectCoordinator()
    
    private func injectCoordinator() -> Coordinator {
        if isRunningUnitTests() {
            logger.info("Injecting Unit Test coordinator")
            return UnusedCoordinator()
        } else {
            logger.info("Injecting Main coordinator")
            return MainCoordinator(navigationController: UINavigationController())
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = coordinator.navigationController
        coordinator.start()
        return true
    }

}

