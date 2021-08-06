//
//  DrinkOrderTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import UIKit

class DrinkOrderTableViewCell: UITableViewCell { // 21.08.06 조혜지 결제하기 Table View Cell

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var ivDrink: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.systemGray6
        } else {
            contentView.backgroundColor = UIColor.systemGray6
        }
    }

}
