//
//  DXRecommendTableDataSource.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit


class DXRecomTableDataSource: NSObject, UITableViewDataSource {
    
    var tableViewTag: Int?
    
    var dataArray: NSMutableArray = []
    
    weak var cellDelegate: DXRecommendCellDelegate?
    
    override init() {
        super.init()
        
        prepareRecommendData()
    }

    func prepareRecommendData() {
        let recommPath = NSBundle.mainBundle().pathForResource("RecommentData", ofType: "plist")
        let recommDict = NSDictionary.init(contentsOfFile: recommPath!)
        
        dataArray = NSMutableArray()
        for key in (recommDict?.allKeys)! {
            let recommValue = recommDict?.valueForKey(key as! String)
            dataArray.addObject(recommValue!)
        }
    }
}


extension DXRecomTableDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: DXRecommendCell = (tableView.dequeueReusableCellWithIdentifier(kRecomdCellIdentifier, forIndexPath: indexPath) as? DXRecommendCell)!;
        cell.delegate = cellDelegate
        
        
        let array: NSArray = dataArray.objectAtIndex(indexPath.row) as! NSArray
        let dataModel = DXRecommendCellData(dataArray: array)
        cell.configureCell(dataModel)
        
        return cell
    }
}