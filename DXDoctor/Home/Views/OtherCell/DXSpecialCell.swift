//
//  DXSpecialTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/17.
//  Copyright © 2016年 Jone. All rights reserved.
// 专题 数据源是假的

import UIKit

protocol DXSpecialCellDelegate: class {
   func specialCellOnClick(_ cell: DXSpecialCell)
}


class DXSpecialCell: UITableViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var overlayImageView: UIImageView!
    
    weak var delegate: DXSpecialCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func specialCellOnTouched(_ sender: AnyObject) {
        
        if (delegate != nil) {
            delegate?.specialCellOnClick(self)
        }
    }
}
