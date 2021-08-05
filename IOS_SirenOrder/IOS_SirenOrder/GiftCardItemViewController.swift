//
//  GiftTab1ViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import UIKit

//category list
var category:[String] = ["축하","감사","응원","사랑","coffee"]
//sub card img Array
var celebration: [String] = []
var thanks: [String] = []
var cheer: [String] = []
var love: [String] = []
var coffee: [String] = []
//main card img Array
var mainCardImgList:[String] = []




class GiftCardItemViewController: UIViewController {
    
    
    //
    var cardData:(String, String, String) = ("","","")
    
    @IBOutlet weak var collectionListTable: UITableView!
    @IBOutlet weak var cardImgChangeControler: UIPageControl!
    @IBOutlet weak var giftCardImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        listappend()
        makeMainImage()
        linkPageControler()
        
        collectionListTable.delegate = self
        collectionListTable.dataSource = self
        collectionListTable.rowHeight = 130
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        self.giftCardImgView.isUserInteractionEnabled = true
        self.collectionListTable.isUserInteractionEnabled = true
        
        self.giftCardImgView.addGestureRecognizer(tapGesture)
//        self.collectionListTable.addGestureRecognizer(tapGesture)
        
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "sgToGift", sender: self)
    }
    
    func listappend() {
        for i in 0..<5 {
            let item: CardModel = allCardImgList[i] as! CardModel
            mainCardImgList.append(item.img!)
        }
        for i in 5..<105 {
            let item: CardModel = allCardImgList[i] as! CardModel
            
            switch i {
            case 5..<25:
                celebration.append(item.img!)
            case 25..<45:
                thanks.append(item.img!)
            case 45..<65:
                cheer.append(item.img!)
            case 65..<85:
                love.append(item.img!)
            case 85..<105:
                coffee.append(item.img!)
            default:
                mainCardImgList.append(item.img!)
            }
            mainCardImgList.append(item.img!)
        }
    }

    func linkPageControler() {
        cardImgChangeControler.numberOfPages = mainCardImgList.count
        cardImgChangeControler.currentPage = 0
        cardImgChangeControler.pageIndicatorTintColor = UIColor.gray
        cardImgChangeControler.currentPageIndicatorTintColor = UIColor.darkGray
    }
    
    @IBAction func cardImgPageChange(_ sender: UIPageControl) {
        makeMainImage()
    }
    
    func makeMainImage() {
        let url = URL(string: mainCardImgList[cardImgChangeControler.currentPage])
        let data = try? Data(contentsOf: url!)
        giftCardImgView.image = UIImage(data: data!)
    }



}


extension GiftCardItemViewController: UITableViewDataSource, UITableViewDelegate, GiftCardTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("여기요 \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "giftCardListCell", for: indexPath) as! GiftCardTableViewCell

        cell.lblListTitle?.text = "\(category[indexPath.row])"
        let background = UIView()
        background.backgroundColor = .clear
        cell.selectedBackgroundView = background
        
        
        
        cell.collectionView.dataSource = self
        cell.collectionView.delegate = self
       

        return cell
    }

    func collectionView(collectionviewcell: GiftCardCollectionViewCell?, index: Int, didTappedInTableViewCell: GiftCardTableViewCell) {
        
        print(GiftCardTableViewCell.nowTab, index)

    }
}
extension GiftCardItemViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? GiftCardCollectionViewCell
        
        let giftCardTableViewCell:GiftCardTableViewCell = GiftCardTableViewCell()
        self.collectionView(collectionviewcell: cell, index: indexPath.item, didTappedInTableViewCell: giftCardTableViewCell)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as? GiftCardCollectionViewCell {
            var item: CardModel = CardModel.init()
            item = allCardImgList[indexPath.row] as! CardModel

            let url = URL(string: item.img!)
            let data = try? Data(contentsOf: url!)
            cell.imgGiftCard.image = UIImage(data: data!)

            return  cell
        }
        return UICollectionViewCell()
        
    }
    
    // Add spaces at the beginning and the end of the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}




// ---
//extension GiftCardItemViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 160, height: 88)
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 20
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! GiftCardCollectionViewCell
//
//        var item: CardModel = CardModel.init()
//        item = allCardImgList[indexPath.row] as! CardModel
//
//        let url = URL(string: item.img!)
//        let data = try? Data(contentsOf: url!)
//        cell.imgGiftCard.image = UIImage(data: data!)
//
//        return  cell
//    }
//
//
//}
