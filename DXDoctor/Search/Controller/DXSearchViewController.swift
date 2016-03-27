//
//  DXSearchViewController.swift
//  DXDoctor
//
//  Created by Jone on 16/2/24.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSearchViewController: DXBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableViewHeaderView: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    var searchItemsArray: [DXSearchItems] {
        get {
            let leftItem0 = SearchItem.init(imageName: "search_item_disease", searchType: "查疾病")
            let middleItem0 = SearchItem.init(imageName: "search_item_medicine", searchType: "查药品")
            let rightItem0 = SearchItem.init(imageName: "search_item_article", searchType: "查文章")
            let firstRowData = DXSearchItems.init(leftItem: leftItem0, middleItem: middleItem0, rightItem: rightItem0)

            let leftItem1 = SearchItem.init(imageName: "search_item_location", searchType: "找药店")
            let middleItem1 = SearchItem.init(imageName: "search_item_vaccine", searchType: "查疫苗")
            let rightItem1 = SearchItem.init(imageName: "search_item_malady", searchType: "常见病症")
            let secondRowData = DXSearchItems.init(leftItem: leftItem1, middleItem: middleItem1, rightItem: rightItem1)
            
            return [firstRowData, secondRowData]
        }
    }
    
    let kSearchCellIdentifier = "kSearchCellIdentifier"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.title = "搜索"
        
        configureTableView()
    }
    
    
    func configureTableView() {
        
        tableView.tableHeaderView = tableViewHeaderView
        tableView.allowsSelection = false
        let nib = UINib(nibName: "DXSearchTableViewCell", bundle: nil)
        tableView.registerNib(nib, forCellReuseIdentifier: kSearchCellIdentifier)
    }
    
    // MARK: Action

    @IBAction func searchButtonOnTouched(sender: AnyObject) {
        print("Search")
//        let searchVC = UIStoryboard.init(name: "Search", bundle: nil).instantiateViewControllerWithIdentifier("DXSearchContentViewController")
//        searchVC.hidesBottomBarWhenPushed = true
        
    }
    @IBAction func qrSacnButtonOnTouched(sender: AnyObject) {
        print("Scan")
    }
    
    override func askDoctorButtonItemOnTapped(sender: UIButton) {
        let askDoctorVC = DXAskDoctorViewController()
        askDoctorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(askDoctorVC, animated: true)
    }
    
}

// MARK: UITableViewDataSource And UITableViewDelegate
extension DXSearchViewController {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DXSearchTableViewCell = tableView .dequeueReusableCellWithIdentifier(kSearchCellIdentifier, forIndexPath: indexPath) as! DXSearchTableViewCell
        let itemData = searchItemsArray[indexPath.row]
        cell.configureCell(itemData)
        return cell
    }
    
    // Delegate
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 120
    }
    

    
}