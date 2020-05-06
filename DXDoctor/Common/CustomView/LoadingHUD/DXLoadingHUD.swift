//
//  DXLoadingHUD.swift
//  CAAnimationTest
//
//  Created by Jone on 16/3/24.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXLoadingHUD: UIView {

    fileprivate var animationView: UIView?
    fileprivate let kRotateDuration = 1.6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(coolView())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func coolView() -> UIView {
        let coolView: DXLoadingComponent = Bundle.main.loadNibNamed("DXLoadingComponent", owner: self, options: nil)!.first as! DXLoadingComponent
        coolView.backgroundColor = UIColor.clear
        coolView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        var center = coolView.center;
        center = self.center
        coolView.center = center
        coolView.layer.add(coolTransformRotate(), forKey: "coolViewRorate")
      
        coolView.refreshOval1.layer.add(coolTransformScaleFirstAndSecond(timeOffset: 0), forKey: "refreshOval1Scale1")
        coolView.refreshOval2.layer.add(coolTransformScaleFirstAndSecond(timeOffset: 0.3), forKey: "refreshOval1Scale2")
        coolView.refreshOval3.layer.add(coolTransformScaleThird(), forKey: "refreshOval1Scale3")
        coolView.refreshOval4.layer.add(coolTransformScaleFirstAndSecond(timeOffset: 0.15), forKey: "refreshOval1Scale4")
        
        return coolView
    }

    // Linear旋转
    fileprivate func transformRotate() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.byValue = Double.pi * 2
        anim.duration = 1
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        return anim
    }
    
    // EaseInEaseOut旋转
    fileprivate func coolTransformRotate() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.byValue = Double.pi * 2
        anim.duration = kRotateDuration
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return anim
    }
    
    // 第一、二、四个圈
    fileprivate func coolTransformScaleFirstAndSecond(timeOffset: CFTimeInterval) -> CABasicAnimation {
        
        let anim = CABasicAnimation(keyPath: "transform.scale")
        
        anim.fromValue = 0.6
        anim.toValue = 1.4
        anim.autoreverses = true
        anim.duration = kRotateDuration / 4
        anim.repeatCount = HUGE
        anim.timeOffset = timeOffset
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        return anim
    }
    
    // 第三个圈
    fileprivate func coolTransformScaleThird() -> CAKeyframeAnimation {
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.values = [1.0, 1.0, 0.6, 1.0]
        anim.keyTimes = [0.0, 0.8, 0.9, 1.0]
        anim.duration = kRotateDuration
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        return anim
    }
}
