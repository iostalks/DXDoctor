//
//  DXPullToRefresh.swift
//  DXDoctor
//
//  Created by Jone on 16/3/18.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXPullToRefresh: UIView {

    
    var refreshingBlock: (()->(Void))?
    
    private var pointImageView: UIImageView?
    private var refreshImageView: UIImageView?
    
    private var associatedScrollView: UIScrollView!
    private var pullDistance: CGFloat = 60
    private var originOffset: CGFloat = 0.0
    private var noTracking: Bool = false // 阻止连续刷新
    private var animation: Bool = false
    
    private var progress: CGFloat? {
    
        didSet {
            let diff = fabs((associatedScrollView?.contentOffset.y)! + originOffset) - pullDistance
//            print("diff :\(diff)")
            if diff > 0 {
                
                if associatedScrollView?.tracking.boolValue == false {
                    
                    if !noTracking {
                        noTracking = true
                        
                        DXAudioManager.manager.playRefreshPullAudio()
                        startAnimation()
//                        print("\(associatedScrollView.contentOffset.y)")
                        UIView.animateWithDuration(0.3, animations: { () -> Void in
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
        self.init(frame: CGRectMake(scrollView.width / 2 - 200 / 2, -60, 200, 60));
        if (hasNavigationBar) {
            originOffset = 64.0
        }
        associatedScrollView = scrollView
        
        setUp()
        
//        let options = .New | .Old why can't?
        associatedScrollView?.addObserver(self, forKeyPath:"contentOffset", options:.New, context:nil)
        associatedScrollView?.insertSubview(self, atIndex: 0)
    }
    
    
    func triggerPulling() {
        associatedScrollView?.setContentOffset(CGPointMake(0, -pullDistance - originOffset), animated: true)
        
    }
  
    func stopRefreshing() {
        
        DXAudioManager.manager.playRefreshSuccessAudio()
        UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: { () -> Void in
            
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
    
    private func setUp() {
        
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
        if keyPath == "contentOffset" {
            let contentOffset = change![NSKeyValueChangeNewKey]
            let offsetY = contentOffset?.CGPointValue.y
            if offsetY < 0 {
                let progress = max(0.0, min(fabs(offsetY! / self.pullDistance), 1.0))
                zoomImageView(progress)
                self.progress = progress
            }
           
//            print("progress: \(progress)")
            //print(self.associatedScrollView?.contentInset.top)
        }
    }
    
    private func zoomImageView(progress: CGFloat) {
        if (progress >= 0.7 && !animation){
            let zoomFactor: CGFloat = min((progress - 0.7) / 0.3, 1.0)
            refreshImageView?.transform = CGAffineTransformMakeScale(zoomFactor, zoomFactor)
        }
    }

    deinit {
        associatedScrollView?.removeObserver(self, forKeyPath: "contentOffset")
    }
}
