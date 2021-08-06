//
//  ConfirmOrderTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/06.
//

import UIKit

class ConfirmOrderTableViewCell: UITableViewCell { // 21.08.06 조혜지 결제 후 결제 정보 확인하는 Table View Cell
    
    @IBOutlet weak var lblDrinkName: UILabel!
    @IBOutlet weak var lblDrinkPersonal: UILabel!
    @IBOutlet weak var lblDrinkCount: UILabel!
    @IBOutlet weak var ivConfirmOrder: UIImageView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.systemGray6
        } else {
            contentView.backgroundColor = UIColor.systemGray6
        }
    }

}
