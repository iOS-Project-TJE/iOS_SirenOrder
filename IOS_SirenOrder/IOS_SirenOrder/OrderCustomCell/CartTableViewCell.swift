//
//  CartTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import UIKit

class CartTableViewCell: UITableViewCell { // 21.08.05 조혜지 장바구니 Table View Cell

    @IBOutlet weak var ivCart: UIImageView!
    @IBOutlet weak var lblDrinkName: UILabel!
    @IBOutlet weak var lblDrinkPrice: UILabel!
    @IBOutlet weak var lblPersonal: UILabel!
    @IBOutlet weak var lblCartCount: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnMinus: UIButton!
    @IBOutlet weak var btnPlus: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var lblPersonalPrice: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }

}
