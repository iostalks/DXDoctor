//
//  DXRecommendTableDataSource.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit


class DXRecomTableDataSource : NSObject {
    
    var tableViewTag: Int?
    
    var dataArray: NSMutableArray = []
    
    weak var cellDelegate: DXRecommendCellDelegate?
    
    override init() {
        super.init()
        
        prepareRecommendData()
    }

    func prepareRecommendData() {
        let recommPath = Bundle.main.path(forResource: "RecommentData", ofType: "plist")
        let recommDict = NSDictionary.init(contentsOfFile: recommPath!)
        
        dataArray = NSMutableArray()
        for key in (recommDict?.allKeys)! {
            let recommValue = recommDict?.value(forKey: key as! String)
            dataArray.add(recommValue!)
        }
    }
}


extension DXRecomTableDataSource : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DXRecommendCell = (tableView.dequeueReusableCell(withIdentifier: kRecomdCellIdentifier, for: indexPath) as? DXRecommendCell)!;
        cell.delegate = cellDelegate
        
        
        let array: NSArray = dataArray.object(at: (indexPath as NSIndexPath).row) as! NSArray
        let dataModel = DXRecommendCellData(dataArray: array)
        cell.configureCell(dataModel)
        
        return cell
    }
}
