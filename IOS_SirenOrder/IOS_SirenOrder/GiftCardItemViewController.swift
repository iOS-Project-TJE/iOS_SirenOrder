//
//  GiftTab1ViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import UIKit

class GiftCardItemViewController: UIViewController {
    
    var allCardImgList: NSArray = NSArray()
    var mainCardImgList:[String] = []
    @IBOutlet weak var cardImgChangeControler: UIPageControl!
    @IBOutlet weak var giftCardImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let giftCardList = GiftCardList()
        giftCardList.delegate = self
        giftCardList.downloadItems()
        
        print(allCardImgList.count)
        
        
        
        // Do any additional setup after loading the view.
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
        allCardImgList = items

        arrayInputImages()
        makeImage()
        linkPageControler()
    }
    
}
