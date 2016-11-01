//
//  DXItemModel.swift
//  DXDoctor
//
//  Created by Jone on 16/6/6.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

public enum DXItemShowType: Int{
    case image      = 1
    case imageNone  = 2
    case smallImageNone = 8
}

struct DXAuthor {
    var identifier: Int
    var name: String
    var url: String
    var avatarURL: String
    var remarks: String
    
    internal init?(authorDict: [String : AnyObject]) {
        guard let iden = authorDict["id"] as? Int,
            let name = authorDict["name"] as? String,
            let url = authorDict["url"] as? String,
            let avatarURL = authorDict["avatar"] as? String,
            let remarks = authorDict["remarks"] as? String else {
                return nil
        }
        
        self.identifier = iden
        self.name = name
        self.url = url
        self.remarks = remarks
        let http = "http:";  // fix
        if !avatarURL.hasPrefix(http) {
            let avatorUrl = http + avatarURL
            self.avatarURL = avatorUrl
        }else {
            self.avatarURL = avatarURL
        }
    }
}

public struct DXItemModel {
    var title: String
    var url: String
    var from: String
    var showType: DXItemShowType
    
    var author: DXAuthor?
    var content: String?
    var tagsStr: String?
    var cover: String?
    

    public init?(json: [String : AnyObject]) {
        
        guard let title = json["title"] as? String,
            let url = json["url"] as? String,
            let from = json["from"] as? String,
            let showTypeIndex = json["show_type"] as? Int,
            let showType = DXItemShowType(rawValue: showTypeIndex)
            else {
            return nil;
        }
        self.title = title
        self.url   = url
        self.from    = from
        self.showType = showType
        
        self.content = json["content"] as? String
        self.tagsStr = json["tags_str"] as? String
        self.cover   = json["cover"] as? String
        
        if let authorDict = json["author"] as? [String : AnyObject] {
            self.author = DXAuthor.init(authorDict: authorDict)
        }
    }
}
