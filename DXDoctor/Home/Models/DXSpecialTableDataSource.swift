//
//  DXSpecialTableDataSource.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSpecialTableDataSource: NSObject, UITableViewDataSource {
    var dataArray: NSMutableArray = []
    weak var cellDelegate: DXSpecialCellDelegate?
    override init() {
        super.init()
        
        prepareSpecialdData()
    }
    
    func prepareSpecialdData() {
        
    }
}

extension DXSpecialTableDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: DXSpecialCell = (tableView.dequeueReusableCellWithIdentifier(kSpecialCellIdentifier, forIndexPath: indexPath) as? DXSpecialCell)!;
        let imageName = "special_cell_\(indexPath.row)"
        let image = UIImage.init(named: imageName)
        cell.overlayImageView.image = image;
        cell.delegate = cellDelegate
        
        return cell
    }
}