//
//  DXSegmentContainerView.swift
//  DXDoctor
//
//  Created by Jone on 16/1/9.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSegmentView: UIView {

    var titles: [String]
    weak var delegate: DXSegmentViewDelegate?
    var titleWidth : CGFloat = 0
    var titleHeight : CGFloat = 0
    
    let kAnimationDuration = 0.15
    
    convenience init(titles: [String], iframe: CGRect) {
        self.init(frame: iframe)
        
        self.frame = iframe;
        self.titles = titles;

        titleWidth = frame.size.width / CGFloat(titles.count)
        titleHeight = frame.size.height
        
        createBottomLabels()
        createTopLabels()
        createTopButton()

    }
    
    override init(frame: CGRect) {
        
        self.titles = [""]; // 默认
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 获取Label frame
    func caculateLabelFrameWithIndex(index: Int) -> CGRect {
        return CGRectMake(CGFloat(index) * titleWidth, 0, titleWidth, titleHeight);
    }
    
    // 创建Label
    func createLabelWithIndex(index : Int, textColor : UIColor) -> UILabel {
        let frame = caculateLabelFrameWithIndex(index)
        let tempLabel = UILabel.init(frame: frame)
        tempLabel.text = titles[index]
        tempLabel.textColor = textColor
        tempLabel.font = UIFont.systemFontOfSize(12.0)
        tempLabel.textAlignment = .Center
        return tempLabel
    }
    
    // 创建下层Label
    func createBottomLabels() {
        for index in 0 ..< titles.count {
            let tempLabel = self.createLabelWithIndex(index, textColor: DXSettingManager.manager.themeColor)
            addSubview(tempLabel)
        }
    }
    
    private var highLightContainerView: UIView?
    private var highColorView: UIView?
    private var topLabelsView: UIView?
    
    // 创建上层Label
    func createTopLabels() {
        
        let itemFrame = CGRectMake(0, 0, titleWidth, titleHeight)
        highLightContainerView = UIView.init(frame: itemFrame)
        highLightContainerView?.clipsToBounds = true
        
        highColorView = UIView.init(frame: itemFrame)
        highColorView?.frame.size = CGSizeMake(titleWidth-10, titleHeight-10)
        highColorView?.center           = (highLightContainerView?.center)!
        highColorView?.backgroundColor  = UIColor(colorLiteralRed: 72/255.00, green: 180/255.00, blue: 166/255.00, alpha: 1)
        highColorView?.layer.cornerRadius = 5.0
        highLightContainerView?.addSubview(highColorView!)
        
        topLabelsView = UIView.init(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        for index in 0 ..< titles.count {
            let topLabel = self.createLabelWithIndex(index, textColor: UIColor.whiteColor())
            topLabel.backgroundColor = UIColor.clearColor()
            topLabelsView?.addSubview(topLabel)
        }
        highLightContainerView?.addSubview(topLabelsView!)
        self.addSubview(highLightContainerView!)
    }
    
    func createTopButton() {
        for index in 0 ..< titles.count {
            let topButton = UIButton(type: .Custom)
            topButton.frame = caculateLabelFrameWithIndex(index)
            topButton.backgroundColor = UIColor.clearColor()
            topButton.tag = index
            topButton.addTarget(self, action: #selector(DXSegmentView.topButtonOnClick(_:)) , forControlEvents: .TouchUpInside)
            addSubview(topButton)
        }
    }
    
    func topButtonOnClick(sender: UIButton) {
        topicItemTappedAtIndex(sender.tag)
    }
    
    func topicItemTappedAtIndex(index: NSInteger) {
        let hightColorViewFrame = caculateLabelFrameWithIndex(index)
        let topLabelsViewFrame = caculateLabelFrameWithIndex(-index)
        
        UIView.animateWithDuration(kAnimationDuration, animations: { () -> Void in
            self.highLightContainerView?.frame = hightColorViewFrame
            self.topLabelsView?.frame = topLabelsViewFrame
            }) { (finished) -> Void in
                if let idelegate = self.delegate {
                    idelegate.segmentItemOnClickedAtIndex(index)
                }
        }
    }
    
}

protocol DXSegmentViewDelegate: class {
    func segmentItemOnClickedAtIndex(index: Int)
}

