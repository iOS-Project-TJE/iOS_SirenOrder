//
//  GiftTab1ViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import UIKit

class GiftCardItemViewController: UIViewController {
    var allCardImgList:[String] = []
    var mainCardImgList:[String] = []
    @IBOutlet weak var cardImgChangeControler: UIPageControl!
    @IBOutlet weak var giftCardImgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        inputImages()
        
        cardImgChangeControler.numberOfPages = mainCardImgList.count
        cardImgChangeControler.currentPage = 0
        cardImgChangeControler.pageIndicatorTintColor = UIColor.gray
        cardImgChangeControler.currentPageIndicatorTintColor = UIColor.darkGray
        // Do any additional setup after loading the view.
    }
    
    func inputImages() {
        
    }

    @IBAction func cardImgPageChange(_ sender: UIPageControl) {
        giftCardImgView.image = UIImage(named: mainCardImgList[cardImgChangeControler.currentPage])
    }


}
