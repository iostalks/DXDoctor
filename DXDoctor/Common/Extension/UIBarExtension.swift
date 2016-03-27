//
//  UIBarExtension.swift
//  DXDoctor
//
//  Created by Jone on 16/3/17.
//  Copyright © 2016年 Jone. All rights reserved.
//

import Foundation
import UIKit

// hide black line belown Navigationbar
extension UINavigationBar {

    func hideBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = true;
    }
    
    func showBottomHairline() {
        let navigationBarImageView = hairlineImageViewInNavigationBar(self)
        navigationBarImageView!.hidden = false;
    }
    
    private func hairlineImageViewInNavigationBar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView = hairlineImageViewInNavigationBar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
    
}

// hide black line top of ToolBar
extension UIToolbar {
    
    func hideHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.hidden = true
    }
    
    func showHairline() {
        let navigationBarImageView = hairlineImageViewInToolbar(self)
        navigationBarImageView!.hidden = false
    }
    
    private func hairlineImageViewInToolbar(view: UIView) -> UIImageView? {
        if view.isKindOfClass(UIImageView) && view.bounds.height <= 1.0 {
            return (view as! UIImageView)
        }
        
        let subviews = (view.subviews as [UIView])
        for subview: UIView in subviews {
            if let imageView: UIImageView = hairlineImageViewInToolbar(subview) {
                return imageView
            }
        }
        
        return nil
    }
    
}