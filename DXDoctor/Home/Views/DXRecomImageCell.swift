//
//  DXRecomImageCell.swift
//  DXDoctor
//
//  Created by Jone on 16/6/7.
//  Copyright © 2016年 Jone. All rights reserved.
//  

/// ShowType == 1, Big cell has background image

import UIKit
import Kingfisher
import YYKit

class DXRecomImageCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var autherImageView: UIImageView!
    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var autherRemarksLabel: UILabel!
    var url: NSURL?
    
    func configWithModel(model: DXItemModel) {
        titleLabel.attributedText = model.title.attributed
        auther.attributedText = model.author?.name.attributed
        autherRemarksLabel.attributedText = model.author?.remarks.attributed;
        
        if let url = NSURL.init(string: model.cover!) {
            backgroundImageView.setImageWithURL(url, placeholder: nil)
        }else {
            
        }
        
        if let author = model.author {
            if let avaterUrl = NSURL.init(string: author.avatarURL) {
                autherImageView.setImageWithURL(avaterUrl, placeholder: nil)
            }else {
                autherImageView.image = UIImage.init(named: "home_doctor_icon")
            }
        }else {
            // 无作者
            print("no author")
        }

    }

}
