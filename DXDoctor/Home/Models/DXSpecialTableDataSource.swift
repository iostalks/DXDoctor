//
//  DXSpecialTableDataSource.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSpecialTableDataSource: NSObject {
    var dataArray: NSMutableArray = []
    weak var cellDelegate: DXSpecialCellDelegate?
    override init() {
        super.init()
        
        prepareSpecialdData()
    }
    
    func prepareSpecialdData() {
        
    }
}

extension DXSpecialTableDataSource : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: DXSpecialCell = (tableView.dequeueReusableCell(withIdentifier: kSpecialCellIdentifier, for: indexPath) as? DXSpecialCell)!;
        let imageName = "special_cell_\((indexPath as NSIndexPath).row)"
        let image = UIImage.init(named: imageName)
        cell.overlayImageView.image = image;
        cell.delegate = cellDelegate
        
        return cell
    }
}
