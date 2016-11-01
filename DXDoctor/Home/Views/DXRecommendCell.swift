//
//  DXRecommendCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/17.
//  Copyright © 2016年 Jone. All rights reserved.

/// Deprecated

import UIKit

class DXRecommendCell: UITableViewCell {

    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var headerDoctorIcon: UIImageView!
    @IBOutlet weak var headerDoctorNameLabel: UILabel!
    @IBOutlet weak var headerDoctorPosition: UILabel!
    
    
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftBriefLabel: UILabel!
    @IBOutlet weak var leftTagLabel: UILabel!
    
    
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightBriefLabel: UILabel!
    @IBOutlet weak var rightTagLabel: UILabel!
    
    
    
    @IBOutlet weak var footerTitleLabel: UILabel!
    @IBOutlet weak var footerBriefLabel: UILabel!
    @IBOutlet weak var footerDoctorIcon: UIImageView!
    @IBOutlet weak var footerDoctorNameLabel: UILabel!
    @IBOutlet weak var footerDoctorPositionLabel: UILabel!

    var dataModel: DXRecommendCellData?
    
    weak var delegate: DXRecommendCellDelegate?
    
    func configureCell(_ dataModel: DXRecommendCellData) {
        headerTitleLabel.attributedText = dataModel.headerTitle?.attributed
        headerImageView.image = UIImage(named: dataModel.headerImageName!)
        headerDoctorIcon.image = UIImage(named: dataModel.headerDoctorIcon!)
        headerDoctorNameLabel.attributedText = dataModel.headerDoctorName?.attributed
        headerDoctorPosition.attributedText = dataModel.headerDoctorPosition?.attributed
        
        leftTitleLabel.attributedText = dataModel.leftTitle?.attributed
        leftBriefLabel.attributedText = dataModel.leftBrief?.attributed
        leftTagLabel.text = dataModel.leftTag
        
        
        rightTitleLabel.attributedText = dataModel.rightTitle?.attributed
        rightBriefLabel.attributedText = dataModel.rightBrief?.attributed
        rightTagLabel.text = dataModel.rightTag
        
        footerTitleLabel.attributedText = dataModel.footerTitle?.attributed
        footerBriefLabel.attributedText = dataModel.footerBrief?.attributed
        footerDoctorIcon.image = UIImage(named: dataModel.footerDoctorIcon!)
        footerDoctorNameLabel.attributedText = dataModel.footerDoctorName?.attributed
        footerDoctorPositionLabel.attributedText = dataModel.footerDoctorPosition?.attributed
        
        self.dataModel = dataModel
    }
    
    
    @IBAction func headerImageViewTapped(_ sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.headerViewOnClick(self)
        }
    }
    
    
    @IBAction func leftViewTapped(_ sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.leftViewOnClick(self)
        }
    }
    
    @IBAction func rightViewTapped(_ sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.rightViewOnClick(self)
        }
    }
 
    @IBAction func footerViewTapped(_ sender: AnyObject) {
        if let delegate = self.delegate {
            delegate.footerViewOnClick(self)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

protocol DXRecommendCellDelegate: class {
    func headerViewOnClick(_ cell: DXRecommendCell)
    func leftViewOnClick(_ cell: DXRecommendCell)
    func rightViewOnClick(_ cell: DXRecommendCell)
    func footerViewOnClick(_ cell: DXRecommendCell)
}
