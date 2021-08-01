//
//  AllMenuTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/07/30.
//

import UIKit

class AllMenuTableViewCell: UITableViewCell { // 2021.07.30 조혜지 TabBar에서 Order Tab 클릭 시 첫 View (메뉴 카테고리)의 Custom Table Cell

    @IBOutlet weak var ivAllMenu: UIImageView!
    @IBOutlet weak var lblAllMenu: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }

}
