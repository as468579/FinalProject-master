//
//  BalanceTableViewCell.swift
//  FinalProject
//
//  Created by User18 on 2019/6/22.
//  Copyright © 2019 User02. All rights reserved.
//

import UIKit

class BalanceTableViewCell: UITableViewCell {

    @IBOutlet weak var eventLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var costLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
