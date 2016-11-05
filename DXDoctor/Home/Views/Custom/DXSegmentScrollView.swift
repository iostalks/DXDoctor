//
//  DXSegmentScrollView.swift
//  DXDoctor
//
//  Created by Jone on 04/11/2016.
//  Copyright © 2016 Jone. All rights reserved.
//

import UIKit
import YYKit

protocol SegmentScrollViewDelegate: NSObjectProtocol {
    func segmentScrollView(_ segmentView: DXSegmentScrollView, tapAtIndex index: Int)
}

class DXSegmentScrollView: UIScrollView {
    
    weak var segmentDelegate: SegmentScrollViewDelegate?
    let kSegmentViewHeight: CGFloat = 36.0

    private var titles: [String]
    
//    private let kHeight: CGFloat = 30
    private let kAnimationDuration = 0.2
    
    private let lableFontSize: CGFloat = 13
    
    private let labelMiddleWith: CGFloat = 16 // label middle gap
    private let labelMarginWith: CGFloat = 8  // label margin
    
    convenience init(titles: [String]) {
        self.init(frame: CGRect.zero)
        let iframe = CGRect.init(x: 0, y: 64, width: UIScreen.main.bounds.size.width, height: kSegmentViewHeight)
        self.frame = iframe
        self.titles = titles
        
        var totalWidth: CGFloat = 0
        for tlt in titles {
            let myString: NSString = tlt as NSString
            let size = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: lableFontSize)])
            let labelWidth = size.width + labelMarginWith * 2
            totalWidth += (labelWidth + labelMiddleWith)
        }
        self.contentSize = CGSize.init(width: CGFloatPixelCeil(totalWidth), height: kSegmentViewHeight)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        createBottomLabels()
        createBottomButton()
        createTopLabels()
    }
    
    override init(frame: CGRect) {
        titles = [""]
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 蓝色标签父视图和白色标签父视图相向移动
    private var scrollViewContentOffset: CGFloat = 0
    public func labelTricksProgress(_ progress: CGFloat) {
        let floor = floorf(Float(progress))
        let index = Int(floor)
        let labelFrame = caculateLabelFrameWithIndex(index)
        let distance = labelFrame.size.width + labelMiddleWith
        let delta = (progress - CGFloat(index))
        let offset = distance * delta
        
        // move
        topContainerView.left = labelFrame.origin.x + offset
        topLabelsView.left = -labelFrame.origin.x - offset
        
        // zooming
        let ceil = ceilf(Float(progress))
        let currentWidth = labelFrame.width
        let nextLabelFrame = caculateLabelFrameWithIndex(Int(ceil))
        let widthOffset = nextLabelFrame.width - currentWidth
//        print(widthOffset, delta, ceil)
        let labelWidth = currentWidth + widthOffset * delta
        topContainerView.width = labelWidth
        highColorView.width = labelWidth
        
        let offsetIndex = max(index-2, 0)
        let offsetPoint = CGPoint.init(x: offsetIndex * 45, y: 0)
        self.setContentOffset(offsetPoint, animated: true)
    }
    
    // Action
    func topicItemTappedAtIndex(_ sender: UIButton) {
        if let idelegate = self.segmentDelegate {
            idelegate.segmentScrollView(self, tapAtIndex: sender.tag)
        }
    }
    
    // MARK: View
    
    // Bottom level label
    private func createBottomLabels() {
        for index in 0 ..< titles.count {
            let tempLabel = createLabelWithIndex(index, textColor: DXSettingManager.manager.themeColor)
            addSubview(tempLabel)
        }
    }
    
    private var topContainerView: UIView! // 颜色移动视图容器
    private var highColorView: UIView!
    private var topLabelsView: UIView!
    
    // Top level label
    private func createTopLabels() {
        let itemFrame = caculateLabelFrameWithIndex(0) // 默认取第一次标签的Frame
        topContainerView = UIView.init(frame: itemFrame)
        topContainerView.clipsToBounds = true
        topContainerView.backgroundColor = UIColor.clear
        
        highColorView = UIView.init(frame: topContainerView.bounds)
        highColorView.backgroundColor  = DXSettingManager.manager.themeColor
        highColorView.layer.cornerRadius = 5.0
        topContainerView.addSubview(highColorView)
        
        var topViewFrame = self.bounds;
        topViewFrame.origin.x -= itemFrame.origin.x
        topViewFrame.origin.y -= itemFrame.origin.y
        topLabelsView = UIView.init(frame: topViewFrame)
        
        for index in 0 ..< titles.count {
            let topLabel = createLabelWithIndex(index, textColor: UIColor.white)
            topLabelsView.addSubview(topLabel)
        }
        topContainerView.addSubview(topLabelsView)
        addSubview(topContainerView)
    }
    
    // Get button 
    func createBottomButton() {
        for index in 0 ..< titles.count {
            let topButton = UIButton(type: .custom)
            topButton.frame = caculateLabelFrameWithIndex(index)
            topButton.backgroundColor = UIColor.clear
            topButton.tag = index
            topButton.titleLabel?.text = titles[index]
            topButton.addTarget(self, action: #selector(DXSegmentScrollView.topicItemTappedAtIndex(_:)) , for: .touchUpInside)
            addSubview(topButton)
        }
    }
    
    // Get label frame at index
    private func caculateLabelFrameWithIndex(_ index: Int) -> CGRect {
        var left: CGFloat = 0
        for idx in 0 ..< index {
            let title = titles[idx]
            let myString: NSString = title as NSString
            let size = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: lableFontSize)])
            left += (size.width + labelMarginWith * 2 + labelMiddleWith)
        }
        
        let currentTitle = titles[index]
        let myString: NSString = currentTitle as NSString
        let size = myString.size(attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: lableFontSize)])
        let originX = CGFloatPixelCeil(left + labelMiddleWith / 2)
        let lWidth = CGFloatPixelCeil(size.width + labelMarginWith * 2)
        let lHeight = CGFloatPixelCeil(size.height) + 4
        let originY = CGFloatPixelCeil((kSegmentViewHeight - lHeight) / 2)
        return CGRect(x: originX, y: originY, width: lWidth, height: lHeight);
    }
    
    // Get label
    private func createLabelWithIndex(_ index : Int, textColor : UIColor) -> UILabel {
        let frame = caculateLabelFrameWithIndex(index)
        let tempLabel = UILabel.init(frame: frame)
        tempLabel.text = titles[index]
        tempLabel.textColor = textColor
        tempLabel.font = UIFont.systemFont(ofSize: lableFontSize)
        tempLabel.textAlignment = .center
        tempLabel.backgroundColor = UIColor.clear
        return tempLabel
    }
}
