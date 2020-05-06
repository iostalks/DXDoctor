//
//  Reusable.swift
//  DXDoctor
//
//  Created by Jone on 2017/8/9.
//  Copyright © 2017年 Jone. All rights reserved.
//

import UIKit

protocol Reusable {
    static var defaultReuseIdentifier: String { get }
}

extension Reusable {
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
    static var nibName: String {
        return String(describing: self)
    }
}

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) where T: Reusable {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: UITableViewCell>(_ nib: T.Type) where T: Reusable {
        register(UINib(nibName: T.nibName, bundle: nil), forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeue UITableViewCell for identifier: \(T.defaultReuseIdentifier) failed")
        }
        return cell
    }
}

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) where T: Reusable {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func registerNib<T: UICollectionViewCell>(_ nib: T.Type) where T: Reusable {
        register(UINib(nibName: T.nibName, bundle: nil), forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, forIndexPath indexPath: IndexPath) -> T where T: Reusable {
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Dequeue UITableViewCell for identifier: \(T.defaultReuseIdentifier) failed")
        }
        return cell
    }
}
