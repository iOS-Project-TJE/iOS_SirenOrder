//
//  CheckTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/08/07.
//

import UIKit

class CheckTableViewCell: UITableViewCell {
    @IBOutlet weak var switchCheck: UISwitch!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
