//
//  GiftCardTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/03.
//

import UIKit

protocol GiftCardTableViewCellDelegate: AnyObject {
    func collectionView(collectionviewcell: GiftCardCollectionViewCell?, index: Int, didTappedInTableViewCell: GiftCardTableViewCell)
}

class GiftCardTableViewCell: UITableViewCell{
   
    weak var cellDelegate: GiftCardTableViewCellDelegate?

    @IBOutlet weak var lblListTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgToGift" {
          
            let cell = sender as! GiftCardCollectionViewCell
            let indexPath = self.collectionView.indexPath(for: cell)
            let payView = segue.destination as! GiftCardPayViewController
            payView.cardData = ("dfs" ,"dafdf")
            
        }
    }
}


    

