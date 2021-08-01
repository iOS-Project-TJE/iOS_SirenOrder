//
//  MyMenuTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/07/30.
//

import UIKit

class MyMenuTableViewCell: UITableViewCell { // 2021.07.31 조혜지 Order 나만의 메뉴 View의 Custom Table Cell

    @IBOutlet weak var lblMyMenuName: UILabel!
    @IBOutlet weak var lblMyMenuPrice: UILabel!
    @IBOutlet weak var lblMyMenuPersonal: UILabel!
    @IBOutlet weak var ivMyMenu: UIImageView!
    @IBOutlet weak var btnCartShape: UIButton!
    @IBOutlet weak var btnOrderShape: UIButton!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }
}
