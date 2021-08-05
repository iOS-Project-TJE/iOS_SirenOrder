//
//  GiftCardPayDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/05.
//

import UIKit

class GiftCardPayDetailViewController: UIViewController {

    @IBOutlet weak var cardImgView: UIImageView!
    @IBOutlet weak var lblReceiver: UILabel!
    @IBOutlet weak var lblText: UILabel!
    @IBOutlet weak var payPrice: UILabel!
    @IBOutlet weak var payMethod: UILabel!
    @IBOutlet weak var sendMethod: UILabel!
    
    var dataList:(String,String,String,String,String,String,String,String,String) = ("","","","","","","","","")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: dataList.2)
        let data = try? Data(contentsOf: url!)
        cardImgView.image = UIImage(data: data!)
        lblReceiver.text =  "\(dataList.3) | \(dataList.4)"
        lblText.text =  dataList.5
        payPrice.text =  dataList.6
        payMethod.text =  dataList.7
        sendMethod.text =  dataList.8
        
        // Do any additional setup after loading the view.
    }
    
    func receiveData(_ cardCd:String, _ cardname: String, _ cardImage: String, _ receiverName: String, _ receiverAddress: String, _ sendMessage:String, _ price:String, _ payMethod: Int, _ sendMethod : Int) {
        dataList.0 = cardCd
        dataList.1 = cardname
        dataList.2 = cardImage
        dataList.3 = receiverName
        dataList.4 = receiverAddress
        dataList.5 = sendMessage
        dataList.6 = price ?? "10000"
        switch payMethod {
        case 1:
            dataList.7 = "휴대폰 결제"
        case 2:
            dataList.7 = "SSG PAY"
        default:
            dataList.7 = "신용카드"
        }
        switch sendMethod {
        case 1:
            dataList.8 = "이메일 전송"
        default:
            dataList.8 = "문자 전송"
        }
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
