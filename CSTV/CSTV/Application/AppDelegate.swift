//
//  AppDelegate.swift
//  CSTV
//
//  Created by Thiago Santiago (Contractor) on 19/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootWindow = UIWindow()
        let navigationController = UINavigationController()
        navigationController.navigationBar.isHidden = true
        rootWindow.rootViewController = navigationController
        rootWindow.makeKeyAndVisible()
        
        window = rootWindow
        
        let initialViewController = MatchesListFactory.make()
        navigationController.pushViewController(initialViewController, animated: true)
        return true
    }
}

