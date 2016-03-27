//
//  DXSearchItem.swift
//  DXDoctor
//
//  Created by Jone on 16/3/21.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSearchItem: NSObject {

    var imageName: String?
    var searchType: String?
    
    init(imageName: String, searchType: String) {
        self.imageName = imageName
        self.searchType = searchType
    }
}
