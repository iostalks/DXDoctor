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
    
    var size: CGSize {
        let width = UIScreen.main.bounds.width
        let height: CGFloat = 210.0
        switch self {
        case .smallImageNone:
            return CGSize(width: width / 2, height: height)
        default:
            return CGSize(width: width, height: height)
        }
    }
    
    var cellIdentifier: String {
        switch self {
        case .image:
            return DXRecomImageCell.defaultReuseIdentifier
        case .imageNone:
            return DXRecomImageNoneCell.defaultReuseIdentifier
        case .smallImageNone:
            return DXRecomSmallImageNoneCell.defaultReuseIdentifier
        }
    }
}

struct DXAuthor {
    let identifier: Int
    let name: String
    let url: String
    let avatarURL: String
    let remarks: String
    
    init?(authorDict: [String : AnyObject]) {
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
        } else {
            self.avatarURL = avatarURL
        }
    }
}

public struct DXItemModel {
    let title: String
    let url: String
    let from: String
    let showType: DXItemShowType
    
    var author: DXAuthor?
    var content: String?
    var tagsStr: String?
    var cover: String?
    
    init?(json: [String : AnyObject]) {
        guard let title = json["title"] as? String,
            let url = json["url"] as? String,
            let from = json["from"] as? String,
            let showTypeIndex = json["show_type"] as? Int,
            let showType = DXItemShowType(rawValue: showTypeIndex)
            else {
            return nil;
        }
        self.title = title
        self.url = url
        self.from  = from
        self.showType = showType
        
        self.content = json["content"] as? String
        self.tagsStr = json["tags_str"] as? String
        self.cover   = json["cover"] as? String
        
        if let authorDict = json["author"] as? [String : AnyObject] {
            self.author = DXAuthor(authorDict: authorDict)
        }
    }
}
