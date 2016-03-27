//
//  DXSpecialTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/17.
//  Copyright © 2016年 Jone. All rights reserved.
// 专题

import UIKit

protocol DXSpecialCellDelegate: class {
   func specialCellOnClick(cell: DXSpecialCell)
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

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func specialCellOnTouched(sender: AnyObject) {
        
        if (delegate != nil) {
            delegate?.specialCellOnClick(self)
        }
    }
}
