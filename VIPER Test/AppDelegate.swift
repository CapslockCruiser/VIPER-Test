//
//  AppDelegate.swift
//  VIPER Test
//
//  Created by William Choi on 6/9/18.
//  Copyright © 2018 William Choi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let rootRouter = RootRouter(environment: .development)
        rootRouter.presentAchievementScreen(in: window!)
        
//        let vc = UIViewController()
//        vc.view.backgroundColor = UIColor.blue
//
//        window?.rootViewController = vc
//        window?.makeKeyAndVisible()
        
        return true
    }

}

