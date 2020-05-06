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
        homeVC.tabBarItem.image = UIImage(named: "V5FootHome")
        homeVC.tabBarItem.selectedImage = UIImage(named: "V5FootHomeSel")
        let searchVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DXSearchViewController");
        searchVC.tabBarItem.title = "搜索"
        searchVC.tabBarItem.image = UIImage(named: "V5FootSearch")
        searchVC.tabBarItem.selectedImage = UIImage(named: "V5FootSearchSel")
        let messageVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DXMessageViewController")
        messageVC.tabBarItem.title = "消息"
        messageVC.tabBarItem.image = UIImage(named: "V5FootInfo")
        messageVC.tabBarItem.selectedImage = UIImage(named: "V5FootInfoSel")
        let homeNavigation = createNavigationController(homeVC)
        homeNavigation.navigationBar.hideBottomHairline()
        let searchNavigation = createNavigationController(searchVC)
        let messageNavigation = createNavigationController(messageVC)

        self.viewControllers = [homeNavigation, searchNavigation, messageNavigation]
    }
    
    private func createNavigationController(_ rootViewController: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootViewController)
        navigationController.navigationBar.barTintColor = UIColor.white
        navigationController.navigationBar.tintColor = DXSettingManager.manager.themeColor
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black];
        return navigationController
    }

}

// MARK: - UITabBarDelegate

extension DXTabBarController {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        DXAudioManager.manager.playTabBabAudio()
    }
}
