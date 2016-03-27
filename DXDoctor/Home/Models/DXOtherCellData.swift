//
//  DXOtherCellData.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXOtherCellData: NSObject {

    
    var title: String?
    var imageName: String?
    
    init(dict: NSDictionary) {
        
        super.init()
        self.title = dict["title"] as? String
        self.imageName = dict["imagName"] as? String
    }
}
