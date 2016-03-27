//
//  DXSearchItems.swift
//  DXDoctor
//
//  Created by Jone on 16/3/21.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSearchItems: NSObject {

    var name: String?
    var leftItem: SearchItem?
    var middleItem: SearchItem?
    var rightItem: SearchItem?
    
    init(leftItem: SearchItem, middleItem: SearchItem, rightItem: SearchItem) {
        self.leftItem = leftItem
        self.middleItem = middleItem;
        self.rightItem = rightItem;
    }
}

public class SearchItem: NSObject {
    var imageName: String?
    var searchType: String?
    
    init(imageName: String, searchType: String) {
        self.imageName = imageName
        self.searchType = searchType
    }
}