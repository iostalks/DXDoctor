//
//  DXModelData.swift
//  DXDoctor
//
//  Created by Jone on 16/4/5.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXMeData: NSObject {

    static let cellTitleName = DXMeData()
    
    var unloginArray: NSArray!
    var baseArray: NSArray!
    var recomArray: NSArray!
    var audioArray: NSArray!
    var otherArray: NSArray!
    var logOutArray: NSArray!
    
    var status: Bool? {
    
        didSet {
            if (status != nil) {
                baseArray = ["头像", "昵称", "性别", "生日"]
            }else {
                baseArray = ["立即登录"]
            }
        }
    }
    
    struct ProperyKey {
        static let baseDataKey = "baseDataKey"
        static let recoKey   = "recoDataKey"
        static let audioKey  = "audioKey"
        static let otherKey  = "otherKey"
        static let logOutKey = "logOutKey"
    }
    
    override init() {
        super.init()
        
        baseArray = ["头像", "昵称", "性别", "生日"]
        recomArray = ["推荐给朋友", "帮助与反馈"]
        audioArray = ["音效设置"]
        otherArray = ["去好评", "隐私保护", "关于我们"]
        logOutArray = ["退出登录"]
    }
    
    
}
