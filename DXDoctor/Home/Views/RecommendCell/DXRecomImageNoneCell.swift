//
//  DXRecomImageNoneCell.swift
//  DXDoctor
//
//  Created by Jone on 16/6/7.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXRecomImageNoneCell: BaseCollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var autherImageView: UIImageView!
    @IBOutlet weak var auther: UILabel!
    @IBOutlet weak var autherRemarks: UILabel!
    
    override func configure(with model: DXItemModel) {
        titleLabel.attributedText = model.title.attributed
        contentLabel.attributedText = model.content?.attributed
        auther.attributedText = model.author?.name.attributed
        autherRemarks.attributedText = model.author?.remarks.attributed
        autherImageView.layer.masksToBounds = true
        if let author = model.author {
            if let avaterUrl = URL(string: author.avatarURL) {
                autherImageView.setImageWith(avaterUrl, placeholder: nil)
            }else {
                autherImageView.image = UIImage.init(named: "home_doctor_icon")
            }
        }else {
            // 无作者
        }

    }
}
