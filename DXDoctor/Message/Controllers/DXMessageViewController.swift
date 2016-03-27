//
//  DXMessageViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/2/24.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXMessageViewController: DXBaseViewController, UITableViewDelegate, UITableViewDataSource {

    let kNewMessageCellIdentifier = "kNewMessageCellIdentifier"
    let kMessageCellIdentifier = "kMessageCellIdentifier"
    
    @IBOutlet var tableViewHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "消息"
        self.view.backgroundColor = UIColor.whiteColor()
        
        configNaviBar()
        configTableView()
        loadMessageData()
        
    }
    
    func configNaviBar() {
        let buttonItem = UIButton(type: .Custom)
        buttonItem.frame = CGRectMake(0, 0, 30, 30);
        buttonItem.setImage(UIImage(named: "message_icon"), forState: .Normal)
        buttonItem.layer.cornerRadius = 15
        buttonItem.layer.masksToBounds = true
        buttonItem.addTarget(self, action: #selector(DXMessageViewController.barButtonItemOnTapped), forControlEvents: .TouchUpInside)
        let leftItem = UIBarButtonItem.init(customView: buttonItem)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    func configTableView() {
        tableViewHeaderView.frame = CGRectMake(0, 0, view.width, 105)
        tableView.tableHeaderView = tableViewHeaderView
        tableView.tableFooterView = UIView()
        tableViewHeaderView.backgroundColor = UIColor.lightGrayColor()
        tableView.registerNib(UINib.init(nibName: "DXNewMessageTableViewCell", bundle: nil), forCellReuseIdentifier: kNewMessageCellIdentifier)
//        tableView.allowsSelection =  false

        tableView.registerNib(UINib(nibName: "DXMessageTableViewCell", bundle: nil), forCellReuseIdentifier: kMessageCellIdentifier)
    }

    func loadMessageData() {
        let path = NSBundle.mainBundle().pathForResource("MessageData", ofType: "plist")
        messages = NSArray.init(contentsOfFile: path!)! as? [NSDictionary]

    }
    
    // MARK: Action
    func barButtonItemOnTapped() {
        
    }
    
    override func askDoctorButtonItemOnTapped(sender: UIButton) {
        let askDoctorVC = DXAskDoctorViewController()
        askDoctorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(askDoctorVC, animated: true)
    }
}

// MARK: TableView
extension DXMessageViewController {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            guard let _ = messages?.count else {
                return 0
            }
            return (messages?.count)!
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch indexPath.section {
            case 0:
                let cell: DXNewMessageTableViewCell = tableView.dequeueReusableCellWithIdentifier(kNewMessageCellIdentifier, forIndexPath: indexPath) as! DXNewMessageTableViewCell
                return cell
            
            case 1:
                let cell: DXMessageTableViewCell = tableView.dequeueReusableCellWithIdentifier(kMessageCellIdentifier, forIndexPath: indexPath) as! DXMessageTableViewCell
                let dict = messages![indexPath.row]
                let messageModel = DXMessageModel.init(dictModel: dict)
   
                cell.configureCell(messageModel)
                return cell
            
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row > 0 {
            let cell: DXMessageTableViewCell = tableView.cellForRowAtIndexPath(indexPath) as! DXMessageTableViewCell
            
            let webViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("DXWebViewController") as! DXWebViewController;
            
            webViewController.hidesBottomBarWhenPushed = true
            webViewController.contentURL = (cell.dataModel?.URL)!
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }
    
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
            return 85
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 8
        }else {
            return 0
        }
    }
}