//
//  NoticeTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/30.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {
    @IBOutlet weak var noNotice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
