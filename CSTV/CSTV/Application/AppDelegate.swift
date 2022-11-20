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
        rootWindow.rootViewController = ViewController()
        rootWindow.makeKeyAndVisible()
        
        window = rootWindow
        
        return true
    }
}

