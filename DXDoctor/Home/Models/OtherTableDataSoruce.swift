//
//  DXOtherTableDataSoruce.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class OtherTableDataSoruce: NSObject {
    
    var dataArray: NSArray = []
    weak var cellDelegate: DXOtherCelDelegate?
    
    override init() {
        super.init()
        prepareData()
    }
    
    func prepareData() {
        guard let otherPath = Bundle.main.path(forResource: "OtherCellData", ofType: "plist"),
            let otherDict = NSDictionary(contentsOfFile: otherPath),
            let array = otherDict["otherCellData"] as? NSArray else {
                return
        }
        dataArray = array
    }
}

extension OtherTableDataSoruce: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    @objc(tableView:cellForRowAtIndexPath:) func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DXOtherCell.self, forIndexPath: indexPath)
        if let dict = dataArray[indexPath.row] as? NSDictionary,
            let cellData = OtherCellModel.from(dict) {
            cell.configCell(cellData)
            cell.delegate = cellDelegate
        }
        return cell
    }
}
