//
//  CategoryDetailTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/01.
//

import UIKit

class CategoryDetailTableViewCell: UITableViewCell { // 2021.08.01 조혜지 Order Category 선택 후 카테고리 별 메뉴 View Custom Table Cell

    @IBOutlet weak var ivCategoryDetail: UIImageView!
    @IBOutlet weak var lblCategoryDetailName: UILabel!
    @IBOutlet weak var lblCategoryDetailPrice: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            contentView.backgroundColor = UIColor.white
        } else {
            contentView.backgroundColor = UIColor.white
        }
    }

}
