//
//  DXMessageViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/2/24.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXMessageViewController: DXBaseViewController, UITableViewDelegate, UITableViewDataSource {

    let kDefaultRowHeight: CGFloat = 85
    let kNewMessageCellIdentifier = "kNewMessageCellIdentifier"
    let kMessageCellIdentifier = "kMessageCellIdentifier"
    
    @IBOutlet var tableViewHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var messages: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "消息"
        self.view.backgroundColor = UIColor.white
        
        configNaviBar()
        configTableView()
        loadMessageData()
        
    }
    
    func configNaviBar() {
        let buttonItem = UIButton(type: .custom)
        buttonItem.frame = CGRect(x: 0, y: 0, width: 30, height: 30);
        buttonItem.setImage(UIImage(named: "message_icon"), for: UIControlState())
        buttonItem.layer.cornerRadius = 15
        buttonItem.layer.masksToBounds = true
        buttonItem.adjustsImageWhenHighlighted = false
        buttonItem.addTarget(self, action: #selector(DXMessageViewController.barButtonItemOnTapped), for: .touchUpInside)
        let leftItem = UIBarButtonItem.init(customView: buttonItem)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    func configTableView() {
        tableViewHeaderView.frame = CGRect(x: 0, y: 0, width: view.width, height: 105)
        tableView.tableHeaderView = tableViewHeaderView
        tableView.tableFooterView = UIView()
        tableViewHeaderView.backgroundColor = UIColor.lightGray
        tableView.register(UINib.init(nibName: "DXNewMessageTableViewCell", bundle: nil), forCellReuseIdentifier: kNewMessageCellIdentifier)

        tableView.register(UINib(nibName: "DXMessageTableViewCell", bundle: nil), forCellReuseIdentifier: kMessageCellIdentifier)
    }

    func loadMessageData() {
        let path = Bundle.main.path(forResource: "MessageData", ofType: "plist")
        messages = NSArray.init(contentsOfFile: path!)! as? [NSDictionary]

    }
    
    // MARK: Action
    func barButtonItemOnTapped() {
        let meStroryBoard = UIStoryboard.init(name: "Message", bundle: nil)
        let meVC = meStroryBoard.instantiateViewController(withIdentifier: "DXSettingViewController")
        meVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(meVC, animated: true)
    }
    
    override func askDoctorButtonItemOnTapped(_ sender: UIButton) {
        let askDoctorVC = DXAskDoctorViewController()
        askDoctorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(askDoctorVC, animated: true)
    }
}

// MARK: TableView
extension DXMessageViewController {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as NSIndexPath).section {
            case 0:
                let cell: DXNewMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: kNewMessageCellIdentifier, for: indexPath) as! DXNewMessageTableViewCell
                return cell
            
            case 1:
                let cell: DXMessageTableViewCell = tableView.dequeueReusableCell(withIdentifier: kMessageCellIdentifier, for: indexPath) as! DXMessageTableViewCell
                let dict = messages![(indexPath as NSIndexPath).row]
                let messageModel = DXMessageModel.init(dictModel: dict)
   
                cell.configureCell(messageModel)
                return cell
            
            default:
                return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if (indexPath as NSIndexPath).row > 0 {
            let cell: DXMessageTableViewCell = tableView.cellForRow(at: indexPath) as! DXMessageTableViewCell
            
            let webViewController = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DXWebViewController") as! DXWebViewController;
            
            webViewController.hidesBottomBarWhenPushed = true
            webViewController.contentURL = (cell.dataModel?.URL)!
            navigationController?.pushViewController(webViewController, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return kDefaultRowHeight
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section > 0 {
            return 8
        }else {
            return 0
        }
    }
}
