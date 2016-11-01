//
//  FFTableViewExtension.swift
//  DXDoctor
//
//  Created by Jone on 16/6/6.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

extension UITableView {
    public func identifier() -> String {
        return "\(self)"
    }
    
    func regClass(_ cell: AnyClass) -> Void {
        register(cell, forCellReuseIdentifier: self.identifier())
    }
}

extension UICollectionView {
    public func identifier() -> String {
        return "\(self)"
    }
    
    func regClass(_ cell: AnyClass) -> Void {
        print(self.identifier())
        register(cell, forCellWithReuseIdentifier: self.identifier())
    }
}
