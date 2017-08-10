//
//  DXSpecialTableDataSource.swift
//  DXDoctor
//
//  Created by Jone on 16/3/26.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class SpecialTableDataSource: NSObject {
    weak var cellDelegate: DXSpecialCellDelegate?
    
    override init() {
        super.init()
        prepareSpecialdData()
    }
    
    func prepareSpecialdData() { }
}

extension SpecialTableDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(DXSpecialCell.self, forIndexPath: indexPath)
        let imageName = "special_cell_\(indexPath.row)"
        let image = UIImage(named: imageName)
        cell.overlayImageView.image = image;
        cell.delegate = cellDelegate
        return cell
    }
}

extension SpecialTableDataSource: TableViewDataSouceCompatible { }
