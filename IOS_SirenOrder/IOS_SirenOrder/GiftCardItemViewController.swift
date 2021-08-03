//
//  GiftTab1ViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import UIKit

class GiftCardItemViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var allCardImgList: NSArray = NSArray()
    //main card img Array
    var mainCardImgList:[String] = []
    
    //category list
    var category:[String] = ["축하","감사","응원","사랑","coffee"]
    //sub card img Array
    var celebration: [String] = []
    var thanks: [String] = []
    var cheer: [String] = []
    var love: [String] = []
    var coffee: [String] = []
    
    @IBOutlet weak var collectionListTable: UITableView!
    @IBOutlet weak var cardImgChangeControler: UIPageControl!
    @IBOutlet weak var giftCardImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let giftCardList = GiftCardList()
        giftCardList.delegate = self
        giftCardList.downloadItems()
        // Do any additional setup after loading the view.
        collectionListTable.rowHeight = 130
    }
    
    
        func numberOfSections(in tableView: UITableView) -> Int {
            // #warning Incomplete implementation, return the number of sections
            return 1
        }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return category.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "giftCardListCell", for: indexPath)
        
//            cell.lbl?.text = "\(category[indexPath.row])"

            return cell
        }
    
    
    func arrayInputImages() {
        for i in 0..<5 {
            let item: CardModel = allCardImgList[i] as! CardModel
            print(item.img!)
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
        makeImage()
    }
    
    func makeImage() {
        let url = URL(string: mainCardImgList[cardImgChangeControler.currentPage])
        let data = try? Data(contentsOf: url!)
        giftCardImgView.image = UIImage(data: data!)
    }

}
extension GiftCardItemViewController: GiftCardListProtocol {
    func itemDownloaded(items: NSArray) {
        print("extension start")
        allCardImgList = items

        arrayInputImages()
        makeImage()
        linkPageControler()
    }
    
}
