//
//  ReceiptTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/08/04.
//

import UIKit

class ReceiptTableViewCell: UITableViewCell {
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
