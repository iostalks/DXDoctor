//
//  DXLoadingHUD.swift
//  CAAnimationTest
//
//  Created by Jone on 16/3/24.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

//enum AnimationType{
//    case Default
//    case Cool
//}

class DXLoadingHUD: UIView {

    private var animationView: UIView?
    private let kRotateDuration = 1.6
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(coolView())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
//        print("loading view deinit")
    }
    
    // 无圆点缩放效果
//    private func defaultView() -> UIView {
//        
//        let animationView = UIView.init(frame: CGRectMake(0, 0, 39, 38))
//        animationView.backgroundColor = UIColor.clearColor()
//        var center = animationView.center;
//        center = self.center
//        animationView.center = center
//        animationView.layer.addAnimation(transformRotate(), forKey: "transformRotate")
//
//        let imageView = UIImageView(image: UIImage(named: "Networkloading"))
//        imageView.frame = CGRectMake(-1, 1, 39, 38)
//        animationView.addSubview(imageView)
//        
//        return animationView
//    }

    
    private func coolView() -> UIView {
        let coolView: DXLoadingComponent = NSBundle.mainBundle().loadNibNamed("DXLoadingComponent", owner: self, options: nil).first as! DXLoadingComponent
        coolView.backgroundColor = UIColor.clearColor()
        coolView.frame = CGRectMake(0, 0, 80, 80)
        var center = coolView.center;
        center = self.center
        coolView.center = center
        coolView.layer.addAnimation(coolTransformRotate(), forKey: "coolViewRorate")
      
        coolView.refreshOval1.layer.addAnimation(coolTransformScaleFirstAndSecond(timeOffset: 0), forKey: "refreshOval1Scale1")
        coolView.refreshOval2.layer.addAnimation(coolTransformScaleFirstAndSecond(timeOffset: 0.3), forKey: "refreshOval1Scale2")
        coolView.refreshOval3.layer.addAnimation(coolTransformScaleThird(), forKey: "refreshOval1Scale3")
        coolView.refreshOval4.layer.addAnimation(coolTransformScaleFirstAndSecond(timeOffset: 0.15), forKey: "refreshOval1Scale4")
        
        return coolView
    }

    // Linear旋转
    private func transformRotate() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.byValue = M_PI * 2
        anim.duration = 1
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        return anim
    }

    // EaseInEaseOut旋转
    private func coolTransformRotate() -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.rotation")
        anim.byValue = M_PI * 2
        anim.duration = kRotateDuration
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        return anim
    }
    
    // 第一、二、四个圈
    private func coolTransformScaleFirstAndSecond(timeOffset timeOffset: CFTimeInterval) -> CABasicAnimation {
        
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
    private func coolTransformScaleThird() -> CAKeyframeAnimation {
        let anim = CAKeyframeAnimation(keyPath: "transform.scale")
        anim.values = [1.0, 1.0, 0.6, 1.0]
        anim.keyTimes = [0.0, 0.8, 0.9, 1.0]
        anim.duration = kRotateDuration
        anim.repeatCount = HUGE
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        return anim
    }
}
