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

        let url = URL(string: cardData.1)
        let data = try? Data(contentsOf: url!)
        cardImageView.image = UIImage(data: data!)
        cardNameLabel.text =  cardData.0
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
