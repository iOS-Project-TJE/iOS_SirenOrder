//
//  CartTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var ivCart: UIImageView!
    @IBOutlet weak var ivCartName: UILabel!
    @IBOutlet weak var ivCartPrice: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }

}
