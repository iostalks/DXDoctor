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
        
        self.logoutLabel.isHidden = true
        self.btnSwitch.isHidden   = true;
        self.iconImageView.isHidden = true
        self.valueLabel.isHidden    = true
        
        self.accessoryType = .disclosureIndicator
        self.textLabel?.textColor = UIColor.darkText
        self.textLabel?.font = UIFont.systemFont(ofSize: 14)
        
    }
    
    @IBAction func btnSwitchOnTouched(_ sender: AnyObject) {
        
    }
}
