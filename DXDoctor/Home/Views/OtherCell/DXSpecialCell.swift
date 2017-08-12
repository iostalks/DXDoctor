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

class DXSpecialCell: UITableViewCell, Reusable {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var overlayImageView: UIImageView!
    
    weak var delegate: DXSpecialCellDelegate?
    
    @IBAction func specialCellOnTouched(_ sender: AnyObject) {
        delegate?.specialCellOnClick(self)
    }
}
