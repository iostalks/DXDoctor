//
//  DXMeTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/4/3.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
   
    @IBOutlet weak var btnSwitch: UISwitch!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var logoutLabel: UILabel!
    @IBOutlet weak var separatorLine: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let selectedView = UIView.init(frame: self.bounds);
        selectedView.backgroundColor = UIColor(red: 243/255.00, green: 243/255.00, blue: 243/255.00, alpha: 0.9)
        self.selectedBackgroundView = selectedView;
        
        self.logoutLabel.hidden = true
        self.btnSwitch.hidden   = true;
        self.iconImageView.hidden = true
        self.valueLabel.hidden    = true
        
        self.accessoryType = .DisclosureIndicator
        self.textLabel?.textColor = UIColor.darkTextColor()
        self.textLabel?.font = UIFont.systemFontOfSize(14)
        
    }
    
    @IBAction func btnSwitchOnTouched(sender: AnyObject) {
        
    }
}
