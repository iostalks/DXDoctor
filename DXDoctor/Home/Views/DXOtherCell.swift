//
//  DXOtherTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

protocol DXOtherCelDelegate: class {
    func otherCellOnClick(_ cell: DXOtherCell)
}

class DXOtherCell: UITableViewCell {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    weak var delegate: DXOtherCelDelegate?
    
    func configCell(data _data: DXOtherCellData) {
        titleLab.text = _data.title
        iconImageView.image = UIImage.init(named: _data.imageName!)
    }
    
    @IBAction func otherCellOnTouched(_ sender: AnyObject) {
        
        if (delegate != nil) {
            delegate?.otherCellOnClick(self)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
