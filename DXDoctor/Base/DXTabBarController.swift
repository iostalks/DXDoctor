//
//  DXTabBarController.swift
//  DXDoctor
//
//  Created by Jone on 16/2/24.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.tintColor = DXSettingManager.manager.themeColor;
        
        let homeVC = DXHomeViewController()
        homeVC.tabBarItem.title = "首页"
        homeVC.tabBarItem.image = UIImage(named: "tab_home")        
        
        let searchVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DXSearchViewController");
        searchVC.tabBarItem.title = "搜索"
        searchVC.tabBarItem.image = UIImage.init(named: "tab_search")
        
        let messageVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DXMessageViewController")
        messageVC.tabBarItem.title = "消息"
        messageVC.tabBarItem.image = UIImage(named: "tab_message")
        
        let homeNavigation = createNavigationController(homeVC)
        homeNavigation.navigationBar.hideBottomHairline()
        let searchNavigation = createNavigationController(searchVC)
        let messageNavigation = createNavigationController(messageVC)

        self.viewControllers = [homeNavigation, searchNavigation, messageNavigation]
    }
    
    fileprivate func createNavigationController(_ rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.tintColor = DXSettingManager.manager.themeColor
        navigationController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.black]
        return navigationController
    }

}

// MARK: - UITabBarDelegate

extension DXTabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        DXAudioManager.manager.playTabBabAudio()
    }
}
