//
//  GiftCardTableViewCell.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/03.
//

import UIKit

protocol CVCellDelegate {
    func selectedCVCell(_ index: (Int,Int))
}

class GiftCardTableViewCell: UITableViewCell{

    var delegate: CVCellDelegate?
    
    @IBOutlet weak var lblListTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var nowIndex: (Int,Int) = (0,0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: false)
        // Configure the view for the selected state
    }
    
}
    

extension GiftCardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        nowIndex.1 = indexPath.item
        
        delegate?.selectedCVCell(nowIndex)
        
//        GiftCardPayViewController.cardData = ("227", "커피컵","https://image.istarbucks.co.kr/cardImg/20150805/000243_WEB.png")
//        self.performSegue(withIdentifier: "sgToGift", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? GiftCardCollectionViewCell {
            var item = ""
            switch nowIndex.0 {
            case 0:
                item = celebration[indexPath.row]
                let url = URL(string: item)
                let data = try? Data(contentsOf: url!)
                cell.imgGiftCard.image = UIImage(data: data!)
            case 1:
                item = thanks[indexPath.row]
                let url = URL(string: item)
                let data = try? Data(contentsOf: url!)
                cell.imgGiftCard.image = UIImage(data: data!)
            case 2:
                item = cheer[indexPath.row]
                let url = URL(string: item)
                let data = try? Data(contentsOf: url!)
                cell.imgGiftCard.image = UIImage(data: data!)
            case 3:
                item = love[indexPath.row]
                let url = URL(string: item)
                let data = try? Data(contentsOf: url!)
                cell.imgGiftCard.image = UIImage(data: data!)
            case 4:
                item = coffee[indexPath.row]
                let url = URL(string: item)
                let data = try? Data(contentsOf: url!)
                cell.imgGiftCard.image = UIImage(data: data!)
            default:
                item = coffee[indexPath.row]
                let url = URL(string: item)
                let data = try? Data(contentsOf: url!)
                cell.imgGiftCard.image = UIImage(data: data!)
            }
            return  cell
        }
        return UICollectionViewCell()
        
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

}
