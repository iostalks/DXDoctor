//
//  DXSegmentContainerView.swift
//  DXDoctor
//
//  Created by Jone on 16/1/9.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXSegmentView: UIView {

    weak var delegate: DXSegmentViewDelegate?

    private var titles: [String]
    private var titleWidth : CGFloat = 0
    private var titleHeight : CGFloat = 0
    
    private let kAnimationDuration = 0.15
    
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
        self .addSubview(scrollView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View
    private var _scrollView: UIScrollView!
    private var scrollView: UIScrollView {
        if (_scrollView == nil) {
            _scrollView = UIScrollView.init(frame: self.frame)
//            _scrollView.delegate = self
            _scrollView.alwaysBounceHorizontal = true
            _scrollView.alwaysBounceVertical = false
//            _scrollView
        }
        return _scrollView
    }
    
    // 获取Label frame
    private func caculateLabelFrameWithIndex(_ index: Int) -> CGRect {
        return CGRect(x: CGFloat(index) * titleWidth, y: 0, width: titleWidth, height: titleHeight);
    }
    
    // 创建Label
    private func createLabelWithIndex(_ index : Int, textColor : UIColor) -> UILabel {
        let frame = caculateLabelFrameWithIndex(index)
        let tempLabel = UILabel.init(frame: frame)
        tempLabel.text = titles[index]
        tempLabel.textColor = textColor
        tempLabel.font = UIFont.systemFont(ofSize: 12.0)
        tempLabel.textAlignment = .center
        return tempLabel
    }
    
    // 创建下层Label
    private func createBottomLabels() {
        for index in 0 ..< titles.count {
            let tempLabel = self.createLabelWithIndex(index, textColor: DXSettingManager.manager.themeColor)
            addSubview(tempLabel)
        }
    }
    
    fileprivate var highLightContainerView: UIView?
    fileprivate var highColorView: UIView?
    fileprivate var topLabelsView: UIView?
    
    // 创建上层Label
    private func createTopLabels() {
        
        let itemFrame = CGRect(x: 0, y: 0, width: titleWidth, height: titleHeight)
        highLightContainerView = UIView.init(frame: itemFrame)
        highLightContainerView?.clipsToBounds = true
        
        highColorView = UIView.init(frame: itemFrame)
        highColorView?.frame.size = CGSize(width: titleWidth-10, height: titleHeight-10)
        highColorView?.center           = (highLightContainerView?.center)!
        highColorView?.backgroundColor  = UIColor(colorLiteralRed: 72/255.00, green: 180/255.00, blue: 166/255.00, alpha: 1)
        highColorView?.layer.cornerRadius = 5.0
        highLightContainerView?.addSubview(highColorView!)
        
        topLabelsView = UIView.init(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        for index in 0 ..< titles.count {
            let topLabel = self.createLabelWithIndex(index, textColor: UIColor.white)
            topLabel.backgroundColor = UIColor.clear
            topLabelsView?.addSubview(topLabel)
        }
        highLightContainerView?.addSubview(topLabelsView!)
        self.addSubview(highLightContainerView!)
    }
    
    func createTopButton() {
        for index in 0 ..< titles.count {
            let topButton = UIButton(type: .custom)
            topButton.frame = caculateLabelFrameWithIndex(index)
            topButton.backgroundColor = UIColor.clear
            topButton.tag = index
            topButton.addTarget(self, action: #selector(DXSegmentView.topButtonOnClick(_:)) , for: .touchUpInside)
            addSubview(topButton)
        }
    }
    
    func topButtonOnClick(_ sender: UIButton) {
        topicItemTappedAtIndex(sender.tag)
    }
    
    func topicItemTappedAtIndex(_ index: NSInteger) {
        let hightColorViewFrame = caculateLabelFrameWithIndex(index)
        let topLabelsViewFrame = caculateLabelFrameWithIndex(-index)
        
        /**
         相向移动蓝色背景的父视图和白色 Label 的父视图
         */
        UIView.animate(withDuration: kAnimationDuration, animations: { () -> Void in
            self.highLightContainerView?.frame = hightColorViewFrame
            self.topLabelsView?.frame = topLabelsViewFrame
            }, completion: { (finished) -> Void in
                if let idelegate = self.delegate {
                    idelegate.segmentItemOnClickedAtIndex(index)
                }
        }) 
    }
    
}

protocol DXSegmentViewDelegate: class {
    func segmentItemOnClickedAtIndex(_ index: Int)
}

