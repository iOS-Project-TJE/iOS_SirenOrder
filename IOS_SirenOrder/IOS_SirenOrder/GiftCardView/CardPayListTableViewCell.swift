//
//  CardPayListTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/05.
//

import UIKit

class CardPayListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblCardName: UILabel!
    @IBOutlet weak var lblPayDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var cardImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
