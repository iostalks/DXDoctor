//
//  DXSettingManager.swift
//  DXDoctor
//
//  Created by Jone on 15/12/5.
//  Copyright © 2015年 Jone. All rights reserved.
//

import UIKit

protocol DXColorProtocol {
    var themeColor: UIColor { get }
    var beigeWhiteColor: UIColor { get }
}


class DXSettingManager: NSObject, DXColorProtocol {
    var themeColor : UIColor {
        get {
            return colorWithRGBA(r: 72, g: 180, b: 166)
        }
    }
    
    var beigeWhiteColor: UIColor {
        get {
           return colorWithRGBA(r: 247, g: 247, b: 247)
        }
    }
    
    static let manager = DXSettingManager()
    
    // This prevents others form using default '()' initializer for this class
    private override init() {}
    
    
    func colorWithRGBA(r red: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: g/255.0, blue: b/255.0, alpha: 255.0)
    }
}
