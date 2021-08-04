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

    @IBOutlet weak var lblListTatle: UILabel!
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
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return category.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! GiftCardCollectionViewCell
////        cell.imgGiftCard.image =
//        let url = URL(string: mainCardImgList[indexPath.row])
//        let data = try? Data(contentsOf: url!)
//        cell.imgGiftCard.image = UIImage(data: data!)
//
//        return cell
//    }
//    // 위 아래 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    // 옆 간격
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 1
//    }
//
//    //cell 사이즈 (옆 라인을 고려하여 설정)
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        //3등분 하여 배치한다, 옆 간격이 1이므로 1을 빼준다.
//        let width = collectionView.frame.width / 3 - 1
//        let size = CGSize(width: width, height: width) //정사각형 만들기
//        return size
//    }

}
//extension GiftCardTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        0
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! GiftCardCollectionViewCell
////        cell.imgGiftCard.image =
//        let url = URL(string: mainCardImgList[indexPath.row])
//        let data = try? Data(contentsOf: url!)
//        cell.imgGiftCard.image = UIImage(data: data!)
//
//        return cell
//    }
//    
//    
//}

    

