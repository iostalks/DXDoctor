//
//  DXMeViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/4/3.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSettingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let kCellIdentifier = "cellIdentifier"
    private let kDefaultRowHeight: CGFloat = 50
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        
        tableView.backgroundView = nil
        tableView.backgroundColor = DXSettingManager.beigeWhiteColor
    }

}

// Table view delegate
// Table view data source
extension DXSettingViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let data = DXMeData.cellTitleName

        switch section {
        case 0:
            return data.baseArray.count
        case 1:
            return data.recomArray.count
        case 2:
            return data.audioArray.count
        case 3:
            return data.otherArray.count
        case 4:
            return data.logOutArray.count
            
        default:
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! DXSettingTableViewCell

        
        let data = DXMeData.cellTitleName
        switch indexPath.section {
        case 0:
            cell.nameLabel?.text = data.baseArray[indexPath.row] as? String
            self .configBaseCell(cell, indexPath: indexPath)
        case 1:
            
            cell.nameLabel?.text = data.recomArray[indexPath.row] as? String
            if indexPath.row == 1 {
                cell.separatorLine.hidden = true
            }
            
        case 2:
            cell.nameLabel?.text = data.audioArray[indexPath.row] as? String
            cell.selectionStyle = .None
            cell.accessoryType = .None
            cell.btnSwitch.hidden = false;
            cell.separatorLine.hidden = true
        case 3:
            cell.nameLabel?.text = data.otherArray[indexPath.row] as? String
            if indexPath.row == 2 {
                cell.separatorLine.hidden = true
            }
        case 4:
            cell.accessoryType = .None
            cell.logoutLabel.hidden = false
            cell.nameLabel.hidden = true
            cell.separatorLine.hidden = true
        default:
            return cell
        }
        
        return cell
    }
    
    func configBaseCell(cell: DXSettingTableViewCell, indexPath: NSIndexPath) {
        switch indexPath.row {
        case 0:
            cell.iconImageView.hidden = false
        case 1:
        
            cell.valueLabel?.text = "Jone"
            cell.valueLabel.hidden = false
        case 2:
            cell.valueLabel?.text = "男"
            cell.valueLabel.hidden = false
        case 3:
            cell.separatorLine.hidden = true
        default:
            cell.valueLabel.hidden = true
        }
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kDefaultRowHeight
    }
}