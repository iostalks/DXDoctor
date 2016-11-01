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
        self.view.backgroundColor = UIColor.white
        self.title = "搜索"
        
        configureTableView()
    }
    
    
    func configureTableView() {
        
        tableView.tableHeaderView = tableViewHeaderView
        tableView.allowsSelection = false
        let nib = UINib(nibName: "DXSearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: kSearchCellIdentifier)
    }
    
    // MARK: Action

    @IBAction func searchButtonOnTouched(_ sender: AnyObject) {
        print("Search")
        let searchVC = UIStoryboard.init(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "DXSearchContentViewController")
        searchVC.hidesBottomBarWhenPushed = true
        searchVC.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(searchVC, animated: true);
        
    }
    @IBAction func qrSacnButtonOnTouched(_ sender: AnyObject) {
        print("Scan")
    }
    
    override func askDoctorButtonItemOnTapped(_ sender: UIButton) {
        let askDoctorVC = DXAskDoctorViewController()
        askDoctorVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(askDoctorVC, animated: true)
    }
    
}

// MARK: UITableViewDataSource And UITableViewDelegate
extension DXSearchViewController {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DXSearchTableViewCell = tableView .dequeueReusableCell(withIdentifier: kSearchCellIdentifier, for: indexPath) as! DXSearchTableViewCell
        let itemData = searchItemsArray[(indexPath as NSIndexPath).row]
        cell.configureCell(itemData)
        return cell
    }
    
    // Delegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    

    
}
