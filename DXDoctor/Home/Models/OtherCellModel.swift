//
//  DXOtherCellData.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

//class DXOtherCellData: NSObject {
//    let title: String
//    let imageName: String
//
//    init(dict: NSDictionary) {
//        super.init()
//        self.title = dict["title"] as? String
//        self.imageName = dict["imagName"] as? String
//    }
//}

struct OtherCellModel {
    let title: String
    let imageName: String
    
    static func from(_ dic: NSDictionary) -> OtherCellModel? {
        guard let title = dic["title"] as? String,
            let name = dic["imageName"] as? String else {
                return nil
        }
        return OtherCellModel(title: title, imageName: name)
    }
}
