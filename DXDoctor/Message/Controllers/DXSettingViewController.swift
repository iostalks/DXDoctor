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
    
    fileprivate let kCellIdentifier = "cellIdentifier"
    fileprivate let kDefaultRowHeight: CGFloat = 50
    fileprivate var cellData: DXSettingCellModel!
    
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
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
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
    
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath) as! DXSettingTableViewCell
        
        
        switch (indexPath as NSIndexPath).section {
        case 0:
            cell.nameLabel?.text = cellData.baseArray[(indexPath as NSIndexPath).row] as? String
            self .configBaseCell(cell, indexPath: indexPath)
        case 1:
            
            cell.nameLabel?.text = cellData.recomArray[(indexPath as NSIndexPath).row] as? String
            if (indexPath as NSIndexPath).row == 1 {
                cell.separatorLine.isHidden = true
            }
            
        case 2:
            cell.nameLabel?.text = cellData.audioArray[(indexPath as NSIndexPath).row] as? String
            cell.selectionStyle = .none
            cell.accessoryType = .none
            cell.btnSwitch.isHidden = false;
            cell.separatorLine.isHidden = true
        case 3:
            cell.nameLabel?.text = cellData.otherArray[(indexPath as NSIndexPath).row] as? String
            if (indexPath as NSIndexPath).row == 2 {
                cell.separatorLine.isHidden = true
            }
        case 4:
            cell.accessoryType = .none
            cell.logoutLabel.isHidden = false
            cell.nameLabel.isHidden = true
            cell.separatorLine.isHidden = true
        default:
            return cell
        }
        
        return cell
    }
    
    func configBaseCell(_ cell: DXSettingTableViewCell, indexPath: IndexPath) {
        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.iconImageView.isHidden = false
            if cellData.status {
                cell.iconImageView.isHidden = true
                cell.valueLabel.isHidden = true
                cell.textLabel?.textColor = DXSettingManager.manager.themeColor
            }
            
        case 1:
        
            cell.valueLabel?.text = "Jone"
            cell.valueLabel.isHidden = false
        case 2:
            cell.valueLabel?.text = "男"
            cell.valueLabel.isHidden = false
        case 3:
            cell.separatorLine.isHidden = true
        default:
            cell.valueLabel.isHidden = true
        }
    }
    
    
    @objc(tableView:didSelectRowAtIndexPath:) func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        switch (indexPath as NSIndexPath).section {
        case 0:
            switch (indexPath as NSIndexPath).row {
            default:
                print("Sectino: \((indexPath as NSIndexPath).section), Row: \((indexPath as NSIndexPath).row)")
            }
        case 1:
            print("Sectino: \((indexPath as NSIndexPath).section), Row: \((indexPath as NSIndexPath).row)")
        case 2:
            print("Sectino: \((indexPath as NSIndexPath).section), Row: \((indexPath as NSIndexPath).row)")
        case 3:
            print("Sectino: \((indexPath as NSIndexPath).section), Row: \((indexPath as NSIndexPath).row)")
        case 4:
            print("Sectino: \((indexPath as NSIndexPath).section), Row: \((indexPath as NSIndexPath).row)")
            self.logout()
        default:
            print("Sectino: \((indexPath as NSIndexPath).section), Row: \((indexPath as NSIndexPath).row)")
        }
        
        
        
        
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return kDefaultRowHeight
    }
}

// MARK: - Cell 点击事件
extension DXSettingViewController {
    
    // 退出登录
    func logout() {
        
        let alertVC = UIAlertController.init(title: "提示", message: "退出后您需要再次登录才能查看个人收藏的各种信息，确定退出？", preferredStyle: .alert)
        alertVC.view.tintColor = DXSettingManager.manager.themeColor
        
        let cancelAction = UIAlertAction.init(title: "取消", style: .default) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let doneAction = UIAlertAction.init(title: "确定", style: .default) { (_) in
            self.cellData.status = false
            self.tableView.reloadData()
        }
        
        alertVC.addAction(cancelAction)
        alertVC.addAction(doneAction)
        self.present(alertVC, animated: true, completion: nil)
        
    }
}





