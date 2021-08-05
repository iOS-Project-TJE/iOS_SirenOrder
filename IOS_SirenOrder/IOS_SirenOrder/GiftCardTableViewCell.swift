//
//  GiftCardTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/03.
//

import UIKit

protocol GiftCardTableViewCellDelegate: class {
    func collectionView(collectionviewcell: GiftCardCollectionViewCell?, index: Int, didTappedInTableViewCell: GiftCardTableViewCell)
}

class GiftCardTableViewCell: UITableViewCell{
   
    static var nowTab:Int = 0
    weak var cellDelegate: GiftCardTableViewCellDelegate?

    @IBOutlet weak var lblListTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
    }
    
}


    

