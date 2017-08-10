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


class DXRecomImageCell: BaseCollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var autherImageView: UIImageView!
    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var autherRemarksLabel: UILabel!
    var url: URL?
    
    override func configure(with model: DXItemModel) {
        titleLabel.attributedText = model.title.attributed
        auther.attributedText = model.author?.name.attributed
        autherRemarksLabel.attributedText = model.author?.remarks.attributed;
        
        if let cover = model.cover, let url = URL(string: cover) {
            backgroundImageView.setImageWith(url, placeholder: nil)
        }
        
        autherImageView.layer.masksToBounds = true
        if let author = model.author {
            if let avaterUrl = URL(string: author.avatarURL) {
                autherImageView.setImageWith(avaterUrl, placeholder: nil)
            } else {
                autherImageView.image = UIImage.init(named: "home_doctor_icon")
            }
        } else {
            // 无作者
        }
    }
}
