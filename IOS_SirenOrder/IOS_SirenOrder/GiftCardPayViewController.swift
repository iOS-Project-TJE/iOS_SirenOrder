//
//  GiftCardPayViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/03.
//

import UIKit

class GiftCardPayViewController: UIViewController {

    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    var cardData:(String, String) = ("","")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://image.istarbucks.co.kr/cardImg/20150805/000944_WEB.png")
        let data = try? Data(contentsOf: url!)
        cardImageView.image = UIImage(data: data!)
        cardNameLabel.text =  "스타벅스 카드"
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
