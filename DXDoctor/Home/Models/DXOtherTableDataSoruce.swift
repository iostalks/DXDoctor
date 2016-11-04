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
        let otherPath = Bundle.main.path(forResource: "OtherCellData", ofType: "plist")
        let otherPathDict = NSDictionary.init(contentsOfFile: otherPath!)
        dataArray = otherPathDict!["otherCellData"] as! NSArray
    }
}

extension DXOtherTableDataSoruce {
    @objc(numberOfSectionsInTableView:) func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: DXOtherCell = (tableView.dequeueReusableCell(withIdentifier: kOtherCellIdentifier, for: indexPath) as? DXOtherCell)!;
        
        let dict = dataArray[(indexPath as NSIndexPath).row] as! NSDictionary
        let cellData = DXOtherCellData.init(dict: dict)
        cell.configCell(data: cellData)
        cell.delegate = cellDelegate
        
        return cell
    }
}
