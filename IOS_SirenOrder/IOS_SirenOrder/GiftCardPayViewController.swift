//
//  GiftCardPayViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/03.
//

import UIKit

class GiftCardPayViewController: UIViewController {

    var userSelect:(Int, String, Int) = (0,"",0)
    
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var tfReceiver: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfSendMessage: UITextView!
    
    
    
    
    var cardData:(String, String, String) = ("227", "커피컵","https://image.istarbucks.co.kr/cardImg/20150805/000243_WEB.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: cardData.2)
        let data = try? Data(contentsOf: url!)
        cardImageView.image = UIImage(data: data!)
        cardNameLabel.text =  cardData.1
        // Do any additional setup after loading the view.
    }
    
    @IBAction func selectSendMethod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            userSelect.0 = 1
        default:
            userSelect.0 = 0
        }
    }
    
    @IBAction func selectPrice(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            userSelect.1 = "30000"
        case 2:
            userSelect.1 = "50000"
        case 3:
            userSelect.1 = "100000"
        case 4:
            userSelect.1 = "그외 금액"
        default:
            userSelect.1 = "10000"
        }
    }
    
    @IBAction func selectPayMethod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            userSelect.2 = 1
        case 2:
            userSelect.2 = 2
        default:
            userSelect.2 = 0
        }
    }
    
    @IBAction func btnGoPay(_ sender: UIButton) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let receiverName = tfReceiver.text
        let receiverAddress = tfAddress.text
        let sendMessage = tfSendMessage.text
        if segue.identifier == "sgCheckPayData" {
            let detailView = segue.destination as! GiftCardPayDetailViewController
            detailView.receiveData(cardData.0, cardData.1, cardData.2, receiverName!, receiverAddress!, sendMessage!, userSelect.1, userSelect.2, userSelect.0)
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
