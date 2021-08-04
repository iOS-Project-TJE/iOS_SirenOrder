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
        self.giftCardImgView.addGestureRecognizer(tapGesture)

        
    }
    @objc func handleTap(sender: UITapGestureRecognizer) { print("tap")
        self.performSegue(withIdentifier: "sgToGift", sender: self)
    }
    
    func listappend() {
        for i in 0..<5 {
            let item: CardModel = allCardImgList[i] as! CardModel
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


extension GiftCardItemViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "giftCardListCell", for: indexPath) as? GiftCardTableViewCell {
            
            cell.collectionView.dataSource = self
            cell.collectionView.delegate = self
            cell.lblListTatle?.text = "\(category[indexPath.row])"
            let background = UIView()
               background.backgroundColor = .clear
               cell.selectedBackgroundView = background


            return cell
        }
        
    
        return UITableViewCell()
    }

}

extension GiftCardItemViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 88)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! GiftCardCollectionViewCell
        
        var item: CardModel = CardModel.init()
        item = allCardImgList[indexPath.row] as! CardModel

        let url = URL(string: item.img!)
        let data = try? Data(contentsOf: url!)
        cell.imgGiftCard.image = UIImage(data: data!)

        return  cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "sqToGift" {
//            let cell = sender as! GiftCardCollectionViewCell
//            let indexPath = self.collectionView.indexPath(for: cell)
//            let detailView = segue.destination as! DetailViewController
//            detailView.receiveItems(imageName[indexPath!.row])
//
//        }
//    }

}
