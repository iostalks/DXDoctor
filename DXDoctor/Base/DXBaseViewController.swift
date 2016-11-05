//
//  DXBaseViewController.swift
//  DXDoctor
//
//  Created by Jone on 15/12/5.
//  Copyright © 2015年 Jone. All rights reserved.
//

import UIKit

class DXBaseViewController: UIViewController {

    fileprivate weak var loadingView: DXLoadingHUD?
    internal var askDoctorView: DXAskDoctorView?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setUpNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.hideLoadingHUD(animation: false)
    }
    
    // 问问医生图标
    func setUpNavigationBar() {
//        let _askDoctorView = DXAskDoctorView.init(frame: CGRect(x: 0, y: 0, width: 46, height: 46))
//        _askDoctorView.delegate = self
//        let rightButtonItem = UIBarButtonItem.init(customView: _askDoctorView)
//        self.askDoctorView = _askDoctorView

        let askImage = UIImage(named: "V5TopAsk");
        let askButton = UIButton.init(type: .custom)
        askButton.frame = CGRect.init(x: 0, y: 0, width: 46, height: 46)
        askButton.setImage(askImage, for: .normal)
        askButton.addTarget(self, action: #selector(DXBaseViewController.askDoctorButtonItemOnTapped), for: .touchUpInside)
        let rightButtonItem = UIBarButtonItem.init(customView: askButton)
        // This way has a bug?
//        let rightButtonItem = UIBarButtonItem.init(image: askImage, style: .plain, target: self, action: ))
        navigationItem.rightBarButtonItem = rightButtonItem;
        
    }
    
    // MARK: HUD
    func showLoadingHUD() {
        
        self.hideLoadingHUD(animation: false)
        
        let _loadView = DXLoadingHUD.init(frame: view.bounds)
        _loadView.backgroundColor = DXSettingManager.manager.beigeWhiteColor
        self.view.addSubview(_loadView)
        self.loadingView = _loadView
        self.loadingView?.alpha = 1.0
    }
    
    func hideLoadingHUD(animation _animation: Bool) {
        
        if _animation {
            UIView.animate(withDuration: 1, animations: { () -> Void in
                
                self.loadingView?.alpha = 0
                
            }, completion: { (_) -> Void in
                
                self.loadingView?.removeFromSuperview()
                self.loadingView = nil
            }) 
            
        }
        else {
            self.loadingView?.removeFromSuperview()
            self.loadingView = nil
        }
    }
}

extension DXBaseViewController {
    func askDoctorButtonItemOnTapped(_ sender: UIBarButtonItem) {
        // Subclass implement
    }
}
