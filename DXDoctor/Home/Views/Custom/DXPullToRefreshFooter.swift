//
//  DXPullToRefreshFooter.swift
//  DXDoctor
//
//  Created by Jone on 16/3/20.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXPullToRefreshFooter: UIView {

    var refreshingBlock: (()->(Void))?
    
    fileprivate var pointImageView: UIImageView?
    fileprivate var refreshImageView: UIImageView?
    
    fileprivate var associatedScrollView: UIScrollView!
    fileprivate var pullDistance: CGFloat = 60
    fileprivate var originOffset: CGFloat = 0.0
    fileprivate var contentSize: CGSize = CGSize(width: 0.0, height: 0.0)
    fileprivate var noTracking: Bool = false // 阻止连续刷新
    fileprivate var animation: Bool = false
    
    var progress: CGFloat? {
        
        didSet {
            
            let diff = associatedScrollView.contentOffset.y - (associatedScrollView.contentSize.height - associatedScrollView.height) - pullDistance + 10.0
            if diff > 0.0 {
  
                if !associatedScrollView.isTracking && !self.isHidden {
                    
                    if !noTracking {
                        noTracking = true
                        
                        DXAudioManager.manager.playRefreshPullAudio()
                        startAnimation()
                        
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            self.associatedScrollView.contentInset = UIEdgeInsetsMake(self.originOffset, 0, self.pullDistance, 0)
                            }, completion: { (_) -> Void in
                                
                                if let block = self.refreshingBlock {
                                    block()
                                }
                        })
                    }
                }
            }
        }
    }

    convenience init(scrollView: UIScrollView, hasNavigationBar: Bool) {
        self.init(frame: CGRect(x: scrollView.width / 2 - 200 / 2, y: scrollView.height, width: 200, height: 60))
        
        if hasNavigationBar {
            originOffset = 64
        }
                
        associatedScrollView = scrollView
        
        setUp()
        associatedScrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        associatedScrollView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        self.isHidden = true
        associatedScrollView.insertSubview(self, at: 0)
        
    }

    func stopRefreshing() {
        
        DXAudioManager.manager.playRefreshSuccessAudio()
        UIView.animate(withDuration: 0.1, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.associatedScrollView?.contentInset = UIEdgeInsetsMake(self.originOffset, 0, 0, 0)
            self.refreshImageView?.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            
            }) { (_) -> Void in
                
                self.noTracking = false
                self.stopAnimation()
        }
    }
    
    func addRefreshingBlock(_ block: @escaping () -> (Void)) {
        refreshingBlock = block
    }
    
    
    func setUp() {
        let radius: CGFloat = 8.0
        pointImageView = UIImageView(image: UIImage(named: "DropDownRefreshCenter"))
        pointImageView?.frame = CGRect(x: self.width / 2 - radius/2, y: self.height / 2 - radius/2, width: radius, height: radius)
        insertSubview(pointImageView!, at: 0)
        
        let width: CGFloat = 39.0
        refreshImageView = UIImageView(image: UIImage(named: "DropdownRefreshSpinner10FPS_00033"))
        refreshImageView?.frame = CGRect(x: self.width / 2 - width / 2, y: self.height/2 - width / 2, width: width, height: 38)
        refreshImageView?.transform = CGAffineTransform(scaleX: 0.0, y: 0.0);
        insertSubview(refreshImageView!, belowSubview: pointImageView!)
    }
    
    // MARK: Help
    fileprivate func startAnimation() {
        refreshImageView?.transform = CGAffineTransform.identity
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = 2 * Double.pi
        rotationAnimation.duration = 1.0
        rotationAnimation.autoreverses = false
        rotationAnimation.repeatCount = HUGE
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        refreshImageView!.layer.add(rotationAnimation, forKey: "rotationAnimation")
        
        animation = true
    }
    
    fileprivate func stopAnimation() {
        refreshImageView?.layer.removeAllAnimations()
        
        animation = false
    }
    
    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard change != nil else {
            return;
        }
        
        if keyPath == "contentSize" {
            contentSize = (change![NSKeyValueChangeKey.newKey] as AnyObject).cgSizeValue
            if contentSize.height > 0.0 {
                self.isHidden = false
            }
            self.frame = CGRect(x: associatedScrollView.width / 2 - 200 / 2, y: contentSize.height, width: 200, height: 60)
        }
        
        if keyPath == "contentOffset" {
            let contentOffset = (change![NSKeyValueChangeKey.newKey] as AnyObject).cgPointValue
            guard (contentOffset != nil) else {
                return;
            }
            
            if contentOffset!.y > (contentSize.height - associatedScrollView.height) {
                self.progress = max(0.0, min((contentOffset!.y - (contentSize.height - associatedScrollView.height)) / pullDistance, 1.0))
//                print("progress: \(self.progress)")
                zoomImageView(self.progress!)
            }
        }
    }
    
    fileprivate func zoomImageView(_ progress: CGFloat) {
        if (progress >= 0.7 && !animation) {
            let zoomFactor: CGFloat = min((progress - 0.7) / 0.3, 1.0)
//            print("footFactor \(zoomFactor)")
            refreshImageView?.transform = CGAffineTransform(scaleX: zoomFactor, y: zoomFactor)
        }
    }
    
    deinit {
        associatedScrollView.removeObserver(self, forKeyPath: "contentOffset")
        associatedScrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
}
