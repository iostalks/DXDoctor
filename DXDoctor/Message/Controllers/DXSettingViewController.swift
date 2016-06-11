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
    
    private let kCellIdentifier = "cellIdentifier"
    private let kDefaultRowHeight: CGFloat = 50
    private var cellData: DXSettingCellModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "设置"
        
        tableView.backgroundView = nil
        tableView.backgroundColor = DXSettingManager.manager.beigeWhiteColor
        
        cellData = DXSettingCellModel.cellTitleName
    }
}

// MARK: - TableView delegate and data source
extension DXSettingViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        let data = DXMeData.cellTitleName

        switch section {
        case 0:
            return cellData.baseArray.count
        case 1:
            return cellData.recomArray.count
        case 2:
            return cellData.audioArray.count
        case 3:
            return cellData.otherArray.count
        case 4:
            return cellData.logOutArray.count
            
        default:
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! DXSettingTableViewCell
        
        
        switch indexPath.section {
        case 0:
            cell.nameLabel?.text = cellData.baseArray[indexPath.row] as? String
            self .configBaseCell(cell, indexPath: indexPath)
        case 1:
            
            cell.nameLabel?.text = cellData.recomArray[indexPath.row] as? String
            if indexPath.row == 1 {
                cell.separatorLine.hidden = true
            }
            
        case 2:
            cell.nameLabel?.text = cellData.audioArray[indexPath.row] as? String
            cell.selectionStyle = .None
            cell.accessoryType = .None
            cell.btnSwitch.hidden = false;
            cell.separatorLine.hidden = true
        case 3:
            cell.nameLabel?.text = cellData.otherArray[indexPath.row] as? String
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
            if cellData.status {
                cell.iconImageView.hidden = true
                cell.valueLabel.hidden = true
                cell.textLabel?.textColor = DXSettingManager.manager.themeColor
            }
            
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
        
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            default:
                print("Sectino: \(indexPath.section), Row: \(indexPath.row)")
            }
        case 1:
            print("Sectino: \(indexPath.section), Row: \(indexPath.row)")
        case 2:
            print("Sectino: \(indexPath.section), Row: \(indexPath.row)")
        case 3:
            print("Sectino: \(indexPath.section), Row: \(indexPath.row)")
        case 4:
            print("Sectino: \(indexPath.section), Row: \(indexPath.row)")
            self.logout()
        default:
            print("Sectino: \(indexPath.section), Row: \(indexPath.row)")
        }
        
        
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return kDefaultRowHeight
    }
}

// MARK: - Cell 点击事件
extension DXSettingViewController {
    
    // 退出登录
    func logout() {
        
        let alertVC = UIAlertController.init(title: "提示", message: "退出后您需要再次登录才能查看个人收藏的各种信息，确定退出？", preferredStyle: .Alert)
        alertVC.view.tintColor = DXSettingManager.manager.themeColor
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .Default) { (_) in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        
        let doneAction = UIAlertAction.init(title: "确定", style: .Default) { (_) in
            self.cellData.status = false
            self.tableView.reloadData()
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(doneAction)
        self.presentViewController(alertVC, animated: true, completion: nil)
        
    }
}





