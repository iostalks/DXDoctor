//
//  DXRecomCollectionViewDataSource.swift
//  DXDoctor
//
//  Created by Jone on 16/6/6.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXRecomCollectionViewDataSource: NSObject, UICollectionViewDataSource {

    override init() {
        super.init()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let  cell = collectionView.dequeueReusableCellWithReuseIdentifier("DXRecomImageCell", forIndexPath: indexPath)
        cell.contentView.backgroundColor = UIColor.redColor()
        return cell
    }
}
