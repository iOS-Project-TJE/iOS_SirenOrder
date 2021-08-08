//
//  GiftTab1ViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import UIKit

//category list
var giftcategory:[String] = ["축하","감사","응원","사랑","coffee"]
//sub card img Array
var celebration: [String] = []
var thanks: [String] = []
var cheer: [String] = []
var love: [String] = []
var coffee: [String] = []
//main card img Array
var mainCardImgList:[String] = []





class GiftCardItemViewController: UIViewController {
    
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
        self.giftCardImgView.addGestureRecognizer(tapGesture)
        
    }
    @objc func handleTap(sender: UITapGestureRecognizer) {
        var item: CardModel = CardModel.init()
        item = allCardImgList[cardImgChangeControler.currentPage] as! CardModel
        
        GiftCardPayViewController.cardData = (item.cd, item.name, item.img)

        self.performSegue(withIdentifier: "sgToGift", sender: self)
    }
    
    func listappend() {
        mainCardImgList = []
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
        cardImgChangeControler.numberOfPages = 5
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


extension GiftCardItemViewController: UITableViewDataSource, UITableViewDelegate{
    
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

        cell.lblListTitle?.text = "\(giftcategory[indexPath.row])"
        cell.nowIndex.0 = indexPath.row
        let background = UIView()
        background.backgroundColor = .clear
        cell.selectedBackgroundView = background
        
        cell.delegate = self

        return cell
    }

}

extension GiftCardItemViewController: CVCellDelegate {
    func selectedCVCell(_ index: (Int,Int)) {
        
        var item: CardModel = CardModel.init()
        print("tab index >>>>>",index.0,">>>>",index.1)
        if index.0 == 0 {
            item = allCardImgList[(index.1)+5] as! CardModel
        }else if index.0 != 0 && index.1 == 0 {
            item = allCardImgList[(index.0)*20+5] as! CardModel
        }else {
            item = allCardImgList[(index.0)*20+(index.1)+5] as! CardModel
        }
        
        
        GiftCardPayViewController.cardData = (item.cd, item.name, item.img)
        self.performSegue(withIdentifier: "sgToGift", sender: self)
    }
    
}


