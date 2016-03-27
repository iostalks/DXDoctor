//
//  DXNewMessageTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/22.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXNewMessageTableViewCell: UITableViewCell {



    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView.init(frame: self.bounds);
        selectedView.backgroundColor = UIColor(red: 243/255.00, green: 243/255.00, blue: 243/255.00, alpha: 0.9)
        self.selectedBackgroundView = selectedView;
    }
    
    
}
