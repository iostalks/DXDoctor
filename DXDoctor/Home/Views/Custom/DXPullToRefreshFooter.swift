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
    
    private var pointImageView: UIImageView?
    private var refreshImageView: UIImageView?
    
    private var associatedScrollView: UIScrollView!
    private var pullDistance: CGFloat = 60
    private var originOffset: CGFloat = 0.0
    private var contentSize: CGSize = CGSizeMake(0.0, 0.0)
    private var noTracking: Bool = false // 阻止连续刷新
    private var animation: Bool = false
    
    var progress: CGFloat? {
        
        didSet {
            
            let diff = associatedScrollView.contentOffset.y - (associatedScrollView.contentSize.height - associatedScrollView.height) - pullDistance + 10.0
            if diff > 0.0 {
  
                if !associatedScrollView.tracking && !self.hidden {
                    
                    if !noTracking {
                        noTracking = true
                        
                        DXAudioManager.manager.playRefreshPullAudio()
                        startAnimation()
                        
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
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
        self.init(frame: CGRectMake(scrollView.width / 2 - 200 / 2, scrollView.height, 200, 60))
        
        if hasNavigationBar {
            originOffset = 64
        }
                
        associatedScrollView = scrollView
        
        setUp()
        associatedScrollView.addObserver(self, forKeyPath: "contentOffset", options: .New, context: nil)
        associatedScrollView.addObserver(self, forKeyPath: "contentSize", options: .New, context: nil)
        
        self.hidden = true
        associatedScrollView.insertSubview(self, atIndex: 0)
        
    }

    func stopRefreshing() {
        
        DXAudioManager.manager.playRefreshSuccessAudio()
        UIView.animateWithDuration(0.1, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            
            self.associatedScrollView?.contentInset = UIEdgeInsetsMake(self.originOffset, 0, 0, 0)
            self.refreshImageView?.transform = CGAffineTransformMakeScale(0.0, 0.0)
            
            }) { (_) -> Void in
                
                self.noTracking = false
                self.stopAnimation()
        }
    }
    
    func addRefreshingBlock(block: () -> (Void)) {
        refreshingBlock = block
    }
    
    
    func setUp() {
        let radius: CGFloat = 8.0
        pointImageView = UIImageView(image: UIImage(named: "DropDownRefreshCenter"))
        pointImageView?.frame = CGRectMake(self.width / 2 - radius/2, self.height / 2 - radius/2, radius, radius)
        insertSubview(pointImageView!, atIndex: 0)
        
        let width: CGFloat = 39.0
        refreshImageView = UIImageView(image: UIImage(named: "DropdownRefreshSpinner10FPS_00033"))
        refreshImageView?.frame = CGRectMake(self.width / 2 - width / 2, self.height/2 - width / 2, width, 38)
        refreshImageView?.transform = CGAffineTransformMakeScale(0.0, 0.0);
        insertSubview(refreshImageView!, belowSubview: pointImageView!)
    }
    
    // MARK: Help
    private func startAnimation() {
        refreshImageView?.transform = CGAffineTransformIdentity
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = 2 * M_PI
        rotationAnimation.duration = 1.0
        rotationAnimation.autoreverses = false
        rotationAnimation.repeatCount = HUGE
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        refreshImageView!.layer.addAnimation(rotationAnimation, forKey: "rotationAnimation")
        
        animation = true
    }
    
    private func stopAnimation() {
        refreshImageView?.layer.removeAllAnimations()
        
        animation = false
    }
    
    // MARK: KVO
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if keyPath == "contentSize" {
            contentSize = (change![NSKeyValueChangeNewKey]?.CGSizeValue())!
            if contentSize.height > 0.0 {
                self.hidden = false
            }
            self.frame = CGRectMake(associatedScrollView.width / 2 - 200 / 2, contentSize.height, 200, 60)
            
        }
        
        if keyPath == "contentOffset" {
            let contentOffset = change![NSKeyValueChangeNewKey]?.CGPointValue
            if contentOffset!.y > (contentSize.height - associatedScrollView.height) {
                self.progress = max(0.0, min((contentOffset!.y - (contentSize.height - associatedScrollView.height)) / pullDistance, 1.0))
//                print("progress: \(self.progress)")
                zoomImageView(self.progress!)
            }
        }
    }
    
    private func zoomImageView(progress: CGFloat) {
        if (progress >= 0.7 && !animation) {
            let zoomFactor: CGFloat = min((progress - 0.7) / 0.3, 1.0)
//            print("footFactor \(zoomFactor)")
            refreshImageView?.transform = CGAffineTransformMakeScale(zoomFactor, zoomFactor)
        }
    }
    
    deinit {
        associatedScrollView.removeObserver(self, forKeyPath: "contentOffset")
        associatedScrollView.removeObserver(self, forKeyPath: "contentSize")
    }
    
}
