//
//  DXSettingManager.swift
//  DXDoctor
//
//  Created by Jone on 15/12/5.
//  Copyright © 2015年 Jone. All rights reserved.
//

import UIKit

class DXSettingManager: NSObject {

    static let themeColor = UIColor(colorLiteralRed: 72 / 255.00, green: 180 / 255.00, blue: 166 / 255.00, alpha: 1.0)
    static let beigeWhiteColor = UIColor(colorLiteralRed: 247.00 / 255.00, green: 247 / 255.00, blue: 247 / 255.00, alpha: 1.0)
    static let manager = DXSettingManager()
    
    // This prevents others form using default '()' initializer for this class
    private override init() {}
}
