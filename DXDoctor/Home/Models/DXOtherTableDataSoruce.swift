//
//  DXOtherTableDataSoruce.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXOtherTableDataSoruce: NSObject, UITableViewDataSource {
    
    var dataArray: NSArray = []
    weak var cellDelegate: DXOtherCelDelegate?
    
    override init() {
        super.init()
        
        prepareOtherData()
    }
    
    func prepareOtherData() {
        let otherPath = NSBundle.mainBundle().pathForResource("OtherCellData", ofType: "plist")
        let otherPathDict = NSDictionary.init(contentsOfFile: otherPath!)
        dataArray = otherPathDict!["otherCellData"] as! NSArray
    }
}

extension DXOtherTableDataSoruce {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: DXOtherCell = (tableView.dequeueReusableCellWithIdentifier(kOtherCellIdentifier, forIndexPath: indexPath) as? DXOtherCell)!;
        
        let dict = dataArray[indexPath.row] as! NSDictionary
        let cellData = DXOtherCellData.init(dict: dict)
        cell.configCell(data: cellData)
        cell.delegate = cellDelegate
        
        return cell
    }
}