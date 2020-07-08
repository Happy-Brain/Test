//
//  DueTableViewCell.swift
//  Happy-Brain-Test-iOS
//
//  Created by 16997598 on 09.07.2020.
//  Copyright © 2020 MikhailSeregin. All rights reserved.
//

import UIKit

class DueTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftIndicatorView: UIView!
    @IBOutlet weak var rightIndicatorView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func configure(with model: Due) {
        self.titleLabel.text = model.smile.title + " " + model.title
        self.leftIndicatorView.backgroundColor = model.smile.color
        self.rightIndicatorView.backgroundColor = model.smile.color
        self.timeLabel.text = DateFormatter.time.string(from: model.time)
    }

}
