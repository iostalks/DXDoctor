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
    
    private struct PropertyKey {
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
        headerTitle = headerDict.valueForKey(PropertyKey.headerTitleKey) as? String
        headerImageName = headerDict.valueForKey(PropertyKey.headerImageNameKey) as? String
        headerDoctorIcon = headerDict.valueForKey(PropertyKey.headerDoctorIconKey) as? String
        headerDoctorName = headerDict.valueForKey(PropertyKey.headerDoctorNameKey) as? String
        headerDoctorPosition = headerDict.valueForKey(PropertyKey.headerDoctorPosition) as? String
        headerUrl = headerDict.valueForKey(PropertyKey.headerUrlKey) as? String
        
        
        let leftDict: NSDictionary = dataArray[1] as! NSDictionary
        leftTitle = leftDict.valueForKey(PropertyKey.leftTitleKey) as? String
        leftBrief = leftDict.valueForKey(PropertyKey.leftBriefKey) as? String
        leftTag   = leftDict.valueForKey(PropertyKey.leftTagKey) as? String
        leftUrl   = leftDict.valueForKey(PropertyKey.leftUrlKey) as? String
        
        let rightDict: NSDictionary = dataArray[2] as! NSDictionary
        rightTitle = rightDict.valueForKey(PropertyKey.rightTitleKey) as? String
        rightBrief = rightDict.valueForKey(PropertyKey.rightBriefKey) as? String
        rightTag   = rightDict.valueForKey(PropertyKey.rightTagKey) as? String
        rightUrl   = rightDict.valueForKey(PropertyKey.rightUrlKey) as? String
        
        let footerDict: NSDictionary = dataArray[3] as! NSDictionary
        footerTitle = footerDict.valueForKey(PropertyKey.footerTitleKey) as? String
        footerBrief = footerDict.valueForKey(PropertyKey.footerBriefKey) as? String
        footerDoctorIcon = footerDict.valueForKey(PropertyKey.footerDoctorIconKey) as? String
        footerDoctorName = footerDict.valueForKey(PropertyKey.footerDoctorNameKey) as? String
        footerDoctorPosition = footerDict.valueForKey(PropertyKey.footerDoctorPositionKey) as? String
        footerUrl = footerDict.valueForKey(PropertyKey.footerUrlKey) as? String
    }
}
