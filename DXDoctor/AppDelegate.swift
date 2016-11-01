//
//  AppDelegate.swift
//  DXDoctor
//
//  Created by Jone on 15/12/5.
//  Copyright © 2015年 Jone. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        self.window?.frame = UIScreen.main.bounds
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        let tabBarViewController = DXTabBarController()
        self.window?.rootViewController = tabBarViewController
        
        return true
    }

}

