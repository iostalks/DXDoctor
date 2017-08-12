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

protocol UIColorConvertible {
    func color() -> UIColor
}

enum DXColor: UInt32 {
    case theme = 0x48b4a6
    case beige = 0xf7f7f7
}

extension DXColor: UIColorConvertible {
    func color() -> UIColor {
        return UIColor(hex: rawValue)
    }
}

extension UIColor {
    public convenience init(hex: UInt32, useAlpha alphaChannel: Bool = false) {
        let mask = 0xFF
        
        let r = Int(hex >> (alphaChannel ? 24 : 16)) & mask
        let g = Int(hex >> (alphaChannel ? 16 : 8)) & mask
        let b = Int(hex >> (alphaChannel ? 8 : 0)) & mask
        let a = alphaChannel ? Int(hex) & mask : 255
        
        let red   = CGFloat(r) / 255
        let green = CGFloat(g) / 255
        let blue  = CGFloat(b) / 255
        let alpha = CGFloat(a) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
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
    fileprivate override init() {}
    
    
    func colorWithRGBA(r red: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: red/255.0, green: g/255.0, blue: b/255.0, alpha: 255.0)
    }
}
