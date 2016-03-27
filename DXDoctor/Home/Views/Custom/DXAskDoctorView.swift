//
//  DXAskDoctorView.swift
//  DXDoctor
//
//  Created by Jone on 16/3/18.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

protocol DXAskDoctorViewDelegate: class {
    func askDoctorButtonItemOnTapped(sender: UIButton)
}

class DXAskDoctorView: UIView {

    private var lightCircleImageView: UIImageView?
    private var middleCircleImageView: UIImageView?
    private var deepCircleImageView: UIImageView?
    
    private var helpImageView: UIImageView?
    
    
    private var firstImageView: UIImageView?
//    private var secondImageView: UIImageView?
//    private var thirdImageView: UIImageView?
    
    weak var delegate: DXAskDoctorViewDelegate?
    
//    var buttonItemClick: (sender: UIButton) -> ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let lightCircleImageView = UIImageView.init(image: UIImage(named: "AskDoctorOvalLight"))
        lightCircleImageView.frame = CGRectMake(-1, 12, 20, 20)
        addSubview(lightCircleImageView)
        self.lightCircleImageView = lightCircleImageView;
        
        let middleCircleImageView = UIImageView.init(image: UIImage(named: "AskDoctorOvalMiddle"))
        middleCircleImageView.frame = CGRectMake(2, 15, 14, 14)
        addSubview(middleCircleImageView)
        self.middleCircleImageView = middleCircleImageView
        
        let askDoctorImage = UIImage(named: "AskDoctoeEarPart")
        let btnItem = UIButton(type: .Custom)
        btnItem .setImage(askDoctorImage, forState: .Normal)
        btnItem.frame = frame
        btnItem .addTarget(self, action: #selector(DXAskDoctorView.askDoctorButtonItemOnClick(_:)), forControlEvents: .TouchUpInside)
        addSubview(btnItem)
        
        let deepCircleImageView = UIImageView.init(image: UIImage(named: "AskDoctorOvialDeep"))
        deepCircleImageView.frame = CGRectMake(5, 18, 8, 8)
        addSubview(deepCircleImageView)
        self.deepCircleImageView = deepCircleImageView
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    let duration: NSTimeInterval = 2.0
    func groupAnimation(timeOffset timeOffset: CFTimeInterval) -> CAAnimationGroup {
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1.0
        scaleAnim.toValue   = 0.2
        scaleAnim.duration  = duration
        scaleAnim.repeatCount = 1
//        scaleAnim.timeOffset = timeOffset
//        scaleAnim.removedOnCompletion = true
//        scaleAnim.fillMode = kCAFillModeBoth
        scaleAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let opacityAnima = CABasicAnimation(keyPath:"opacity")
        
        opacityAnima.fromValue = 0.2
        opacityAnima.toValue   = 1.0
        opacityAnima.duration  = duration
        opacityAnima.repeatCount = 1
//        opacityAnima.timeOffset = timeOffset
//        opacityAnima.removedOnCompletion = true
        opacityAnima.fillMode = kCAFillModeBoth
        opacityAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)

        let groupAnima = CAAnimationGroup()
        groupAnima.duration = duration
        groupAnima.repeatCount = 1
//        groupAnima.timeOffset = timeOffset
        
        groupAnima.removedOnCompletion = true
        groupAnima.fillMode = kCAFillModeBoth
        groupAnima.animations = [scaleAnim, opacityAnima]
        
        return groupAnima
    }

    func askDoctorButtonItemOnClick(sender: UIButton) {
        delegate?.askDoctorButtonItemOnTapped(sender)
    }
    
    func startAnimation() {
        
        middleCircleImageView?.transform = CGAffineTransformMakeScale(0.2, 0.2)
//        firstImageView = UIImageView.init(image: UIImage(named: "AskDoctorOvalMiddle"))
//        firstImageView?.frame = CGRectMake(2, 15, 14, 14)
//        insertSubview(firstImageView!, aboveSubview: self.middleCircleImageView!)
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1.3
        scaleAnim.toValue   = 0.2
        scaleAnim.duration  = duration
        scaleAnim.repeatCount = 1
        scaleAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let opacityAnima = CABasicAnimation(keyPath:"opacity")
        
        opacityAnima.fromValue = 1.0
        opacityAnima.toValue   = 1.0
        opacityAnima.duration  = duration
        opacityAnima.repeatCount = 1
        opacityAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let groupAnima = CAAnimationGroup()
        groupAnima.duration = duration
        groupAnima.repeatCount = 1
        groupAnima.animations = [scaleAnim, opacityAnima]
//        groupAnima.fillMode = kCAFillModeRemoved
        middleCircleImageView?.layer.addAnimation(groupAnima, forKey: "firstAnimation")
        
        secondAnimation()
    }
    
    let secondBeginTime = 1.0
    func secondAnimation() {
        
        let secondImageView = UIImageView.init(image: UIImage(named: "AskDoctorOvalMiddle"))
        secondImageView.frame = CGRectMake(2, 15, 14, 14)
        insertSubview(secondImageView, aboveSubview: middleCircleImageView!)
//        self.addSubview(secondImageView)
        secondImageView.transform = CGAffineTransformMakeScale(0.2, 0.2)
        
        
        let scaleAnim = CABasicAnimation(keyPath: "transform.scale")
        scaleAnim.fromValue = 1.3
        scaleAnim.toValue   = 0.2
        scaleAnim.duration  = duration
        scaleAnim.repeatCount = 1
        scaleAnim.beginTime = secondBeginTime
        scaleAnim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        let opacityAnima = CABasicAnimation(keyPath:"opacity")
        
        opacityAnima.fromValue = 1.0
        opacityAnima.toValue   = 1.0
        opacityAnima.duration  = duration
        opacityAnima.repeatCount = 1
        opacityAnima.beginTime = secondBeginTime
        opacityAnima.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        let groupAnima = CAAnimationGroup()
        groupAnima.duration = duration
        groupAnima.repeatCount = 1
        groupAnima.beginTime = secondBeginTime
        groupAnima.animations = [scaleAnim, opacityAnima]
        
        secondImageView.layer.addAnimation(groupAnima, forKey: "secondAnimation")
    }
    
    func thirdAniation() {
        
    }
    
}

// MARK: Animation Delegate
extension DXBaseViewController {
 
}