//
//  AllStoreTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/07/31.
//

import UIKit

class AllStoreTableViewCell: UITableViewCell { // 21.07.31 조혜지 Order 전체 매장 Table View Cell

    @IBOutlet weak var lblAllStoreName: UILabel!
    @IBOutlet weak var lblAllStoreAddress: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }

}
