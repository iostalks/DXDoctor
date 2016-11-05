//
//  DXPullToRefresh.swift
//  DXDoctor
//
//  Created by Jone on 16/3/18.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}


class DXPullToRefresh: UIView {
    
    var refreshingBlock: (()->(Void))?
    
    fileprivate var pointImageView: UIImageView?
    fileprivate var refreshImageView: UIImageView?
    
    fileprivate var associatedScrollView: UIScrollView!
    fileprivate var pullDistance: CGFloat = 60
    fileprivate var originOffset: CGFloat = 0.0
    fileprivate var noTracking: Bool = false // 阻止连续刷新
    fileprivate var animation: Bool = false
    
    fileprivate var progress: CGFloat? {
    
        didSet {
            let diff = fabs((associatedScrollView?.contentOffset.y)! + originOffset) - pullDistance
//            print("diff :\(diff)")
            if diff > 0 {
                
                if associatedScrollView?.isTracking == false {
                    
                    if !noTracking {
                        noTracking = true
                        
                        DXAudioManager.manager.playRefreshPullAudio()
                        startAnimation()
//                        print("\(associatedScrollView.contentOffset.y)")
                        UIView.animate(withDuration: 0.3, animations: { () -> Void in
                            self.associatedScrollView?.contentInset = UIEdgeInsetsMake(self.pullDistance + self.originOffset, 0, 0, 0)
                            }, completion: { (_) -> Void in
                                
                                if let block = self.refreshingBlock {
                                    block()
                                }
                        })
                    }
                }
               
            }
            else {
                
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(scrollView: UIScrollView , hasNavigationBar: Bool) {
        self.init(frame: CGRect(x: scrollView.width / 2 - 200 / 2, y: -60, width: 200, height: 60));
        if (hasNavigationBar) {
            originOffset = 64.0
        }
        associatedScrollView = scrollView
        
        setUp()
        
//        let options = .New | .Old why can't?
        associatedScrollView?.addObserver(self, forKeyPath:"contentOffset", options:.new, context:nil)
        associatedScrollView?.insertSubview(self, at: 0)
    }
    
    
    func triggerPulling() {
        associatedScrollView?.setContentOffset(CGPoint(x: 0, y: -pullDistance - originOffset), animated: true)
        
    }
  
    func stopRefreshing() {
        
        DXAudioManager.manager.playRefreshSuccessAudio()
        UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
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
    
    fileprivate func setUp() {
        
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
        rotationAnimation.toValue = 2 * M_PI
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

        if keyPath == "contentOffset" {
            let contentOffset = change![NSKeyValueChangeKey.newKey]
            let offsetY = (contentOffset as AnyObject).cgPointValue.y
            if offsetY < 0 {
                let progress = max(0.0, min(fabs(offsetY / self.pullDistance), 1.0))
                zoomImageView(progress)
                self.progress = progress
            }
           
//            print("progress: \(progress)")
            //print(self.associatedScrollView?.contentInset.top)
        }
    }
    
    fileprivate func zoomImageView(_ progress: CGFloat) {
        if (progress >= 0.7 && !animation){
            let zoomFactor: CGFloat = min((progress - 0.7) / 0.3, 1.0)
            refreshImageView?.transform = CGAffineTransform(scaleX: zoomFactor, y: zoomFactor)
        }
    }

    deinit {
        associatedScrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
}
