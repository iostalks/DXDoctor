//
//  DXRecommendCellData.swift
//  DXDoctor
//
//  Created by Jone on 16/3/19.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXRecommendCellData: NSObject {

    var headerTitle: String?
    var headerImageName: String?
    var headerDoctorIcon: String?
    var headerDoctorName: String?
    var headerDoctorPosition: String?
    var headerUrl: String?
    
    var leftTitle: String?
    var leftBrief: String?
    var leftTag: String?
    var leftUrl: String?
    
    
    var rightTitle: String?
    var rightBrief: String?
    var rightTag: String?
    var rightUrl: String?
    
    var footerTitle: String?
    var footerBrief: String?
    var footerDoctorIcon: String?
    var footerDoctorName: String?
    var footerDoctorPosition: String?
    var footerUrl: String?
    
    fileprivate struct PropertyKey {
        static let headerTitleKey = "headerTitle"
        static let headerImageNameKey = "headerImageName"
        static let headerDoctorIconKey = "headerDoctorIcon"
        static let headerDoctorNameKey = "headerDoctorName"
        static let headerDoctorPosition = "headerDoctorPosition"
        static let headerUrlKey = "headerUrl"
        
        static let leftTitleKey = "leftTitle"
        static let leftBriefKey = "leftBrief"
        static let leftTagKey = "leftTag"
        static let leftUrlKey = "leftUrl"
        
        static let rightTitleKey = "rightTitle"
        static let rightBriefKey = "rightBrief"
        static let rightTagKey = "rightTag"
        static let rightUrlKey = "rightUrl"
        
        static let footerTitleKey = "footerTitle"
        static let footerBriefKey = "footerBrief"
        static let footerDoctorIconKey = "footerDoctorIcon"
        static let footerDoctorNameKey = "footerDoctorName"
        static let footerDoctorPositionKey = "footerDoctorPosition"
        static let footerUrlKey = "footerUrl"
        
    }
    
    convenience init(dataArray: NSArray) {
        self.init()
        
        guard dataArray.count > 3 else {
            return
        }
        
        let headerDict: NSDictionary = dataArray[0] as! NSDictionary
        headerTitle = headerDict.value(forKey: PropertyKey.headerTitleKey) as? String
        headerImageName = headerDict.value(forKey: PropertyKey.headerImageNameKey) as? String
        headerDoctorIcon = headerDict.value(forKey: PropertyKey.headerDoctorIconKey) as? String
        headerDoctorName = headerDict.value(forKey: PropertyKey.headerDoctorNameKey) as? String
        headerDoctorPosition = headerDict.value(forKey: PropertyKey.headerDoctorPosition) as? String
        headerUrl = headerDict.value(forKey: PropertyKey.headerUrlKey) as? String
        
        
        let leftDict: NSDictionary = dataArray[1] as! NSDictionary
        leftTitle = leftDict.value(forKey: PropertyKey.leftTitleKey) as? String
        leftBrief = leftDict.value(forKey: PropertyKey.leftBriefKey) as? String
        leftTag   = leftDict.value(forKey: PropertyKey.leftTagKey) as? String
        leftUrl   = leftDict.value(forKey: PropertyKey.leftUrlKey) as? String
        
        let rightDict: NSDictionary = dataArray[2] as! NSDictionary
        rightTitle = rightDict.value(forKey: PropertyKey.rightTitleKey) as? String
        rightBrief = rightDict.value(forKey: PropertyKey.rightBriefKey) as? String
        rightTag   = rightDict.value(forKey: PropertyKey.rightTagKey) as? String
        rightUrl   = rightDict.value(forKey: PropertyKey.rightUrlKey) as? String
        
        let footerDict: NSDictionary = dataArray[3] as! NSDictionary
        footerTitle = footerDict.value(forKey: PropertyKey.footerTitleKey) as? String
        footerBrief = footerDict.value(forKey: PropertyKey.footerBriefKey) as? String
        footerDoctorIcon = footerDict.value(forKey: PropertyKey.footerDoctorIconKey) as? String
        footerDoctorName = footerDict.value(forKey: PropertyKey.footerDoctorNameKey) as? String
        footerDoctorPosition = footerDict.value(forKey: PropertyKey.footerDoctorPositionKey) as? String
        footerUrl = footerDict.value(forKey: PropertyKey.footerUrlKey) as? String
    }
}
