//
//  HistoryTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/30.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var ivHistoryImg: UIImageView!
    @IBOutlet weak var lblHistoryName: UILabel!
    @IBOutlet weak var lblHistoryDate: UILabel!
    @IBOutlet weak var lblHistoryLocation: UILabel!
    @IBOutlet weak var lblHistoryPrice: UILabel!
    @IBOutlet weak var lblOrderComplete: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
