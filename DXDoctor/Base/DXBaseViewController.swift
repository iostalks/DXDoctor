//
//  DXBaseViewController.swift
//  DXDoctor
//
//  Created by Jone on 15/12/5.
//  Copyright © 2015年 Jone. All rights reserved.
//

import UIKit

class DXBaseViewController: UIViewController, DXAskDoctorViewDelegate {

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
        
        let _askDoctorView = DXAskDoctorView.init(frame: CGRect(x: 0, y: 0, width: 46, height: 46))
        _askDoctorView.delegate = self
        
        let rightButtonItem = UIBarButtonItem.init(customView: _askDoctorView)
        navigationItem.rightBarButtonItem = rightButtonItem;
        
        self.askDoctorView = _askDoctorView
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
    func askDoctorButtonItemOnTapped(_ sender: UIButton) {
        // Subclass implement
    }
}
