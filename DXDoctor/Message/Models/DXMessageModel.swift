//
//  DXMessageModel.swift
//  DXDoctor
//
//  Created by Jone on 16/3/22.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXMessageModel: NSObject {

    var title: String!
    var tag: String!
    var URL: String!
    
    struct PropertyKey {
        static let titleKey = "title"
        static let tagKey = "tag"
        static let urlKey = "URL"
    }
    
    init(dictModel: NSDictionary) {
        self.title = dictModel.value(forKey: PropertyKey.titleKey) as! String
        self.tag   = dictModel.value(forKey: PropertyKey.tagKey) as! String
        self.URL   = dictModel.value(forKey: PropertyKey.urlKey) as! String
    }
}
