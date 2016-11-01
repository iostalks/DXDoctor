
//  DXMessageTableViewCell.swift
//  DXDoctor
//
//  Created by Jone on 16/3/22.
//  Copyright © 2016年 Jone. All rights reserved.
//

import UIKit

class DXMessageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var tagBackgroudView: UIView!
    var dataModel: DXMessageModel?
    
    func configureCell(_ data: DXMessageModel) {
        titleLabel.text = data.title
        tagLabel.text = data.tag
        dataModel = data
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView.init(frame: self.bounds);
        selectedView.backgroundColor = UIColor(red: 243/255.00, green: 243/255.00, blue: 243/255.00, alpha: 0.9)
        self.selectedBackgroundView = selectedView;
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            tagBackgroudView.backgroundColor = UIColor(red: 170/255.00, green: 170/255.00, blue: 170/255.00, alpha: 0.8)
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated);
        if highlighted {
            tagBackgroudView.backgroundColor = UIColor(red: 170/255.00, green: 170/255.00, blue: 170/255.00, alpha: 0.8)
        }
    }
}
