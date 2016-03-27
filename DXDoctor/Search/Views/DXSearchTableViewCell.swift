//
//  DXSearchTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/21.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSearchTableViewCell: UITableViewCell {

    @IBOutlet weak var leftImageView: UIImageView!
    @IBOutlet weak var leftSearchTypeLabel: UILabel!
    
    
    @IBOutlet weak var middleImageView: UIImageView!
    @IBOutlet weak var middleSearchTypeLabel: UILabel!
    
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var rightSearchTypeLabel: UILabel!
    
    
    
    func configureCell(rowItems: DXSearchItems) {

        let leftImageName = rowItems.leftItem?.imageName
        let leftSearchType = rowItems.leftItem?.searchType
        leftImageView.image = UIImage(named: leftImageName!)
        leftSearchTypeLabel.text = leftSearchType
        
        let middleImageName = rowItems.middleItem?.imageName
        let middleSearchType = rowItems.middleItem?.searchType
        middleImageView.image = UIImage(named: middleImageName!)
        middleSearchTypeLabel.text = middleSearchType
        
        let rightImageName = rowItems.rightItem?.imageName
        let rightSearchType = rowItems.rightItem?.searchType
        rightImageView.image = UIImage(named: rightImageName!)
        rightSearchTypeLabel.text = rightSearchType
        
    }
    
    
    @IBAction func leftButtonOnTouched(sender: AnyObject) {
    }
    
    @IBAction func middleButtonOnTouched(sender: AnyObject) {
    }
    @IBAction func rightButtonOnTouched(sender: AnyObject) {
    }
}
