//
//  UIViewExtension.swift
//  DXDoctor
//
//  Created by Jone on 16/3/17.
//  Copyright © 2016年 Jone. All rights reserved.
//


import UIKit

extension UIView {
    
//    var size: CGSize {
//        get {
//            return self.frame.size
//        }
//    }
//    
//    var width: CGFloat {
//        get {
//            return self.frame.size.width
//        }
//    }
//    
//    var height: CGFloat {
//        get {
//            return self.frame.size.height
//        }
//    }
//    
    var x: CGFloat {
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        get {
            return self.frame.origin.y
        }
    }
//    var centerX: CGFloat {
//        get {
//            return self.center.x
//        }
//    }
//    
//    var centerY: CGFloat {
//        get {
//            return self.center.y
//        }
//    }
}