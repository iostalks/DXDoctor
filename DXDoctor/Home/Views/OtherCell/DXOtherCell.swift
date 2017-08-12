//
//  DXOtherTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//  真相，慢病... 数据源是假的

import UIKit

protocol DXOtherCelDelegate: NSObjectProtocol {
    func otherCellOnClick(_ cell: DXOtherCell)
}

class DXOtherCell: UITableViewCell, Reusable {
    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    weak var delegate: DXOtherCelDelegate?
    
    func configCell(_ model: OtherCellModel) {
        titleLab.text = model.title
        iconImageView.image = UIImage(named: model.imageName)
    }
    
    @IBAction func otherCellOnTouched(_ sender: AnyObject) {
        delegate?.otherCellOnClick(self)
    }
}
