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
    
    var dataList:(String,String,String,String,String,String) = ("","","","","","")
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: GiftCardPayViewController.cardData.2!)
        let data = try? Data(contentsOf: url!)
        cardImgView.image = UIImage(data: data!)
        lblReceiver.text =  "\(dataList.0) | \(dataList.1)"
        lblText.text =  dataList.2
        payPrice.text =  dataList.3
        payMethod.text =  dataList.4
        sendMethod.text =  dataList.5
        
        // Do any additional setup after loading the view.
    }
    
    func receiveData(_ receiverName: String, _ receiverAddress: String, _ sendMessage:String, _ price:String?, _ payMethod: Int, _ sendMethod : Int) {
        dataList.0 = receiverName
        dataList.1 = receiverAddress
        dataList.2 = sendMessage
        dataList.3 = price ?? "10000"
        switch payMethod {
        case 1:
            dataList.4 = "휴대폰 결제"
        case 2:
            dataList.4 = "SSG PAY"
        default:
            dataList.4 = "신용카드"
        }
        switch sendMethod {
        case 1:
            dataList.5 = "문자 전송"
        default:
            dataList.5 = "이메일 전송"
        }
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func btnPayFinish(_ sender: UIButton) {
        
        let giftInsert = GiftSend()
        let result = giftInsert.insertItems(giftSender: "\(userId)", giftReceiver: dataList.0, card_cd: GiftCardPayViewController.cardData.0!, price: dataList.3)
        
        if result {
            let resultAlert = UIAlertController(title: "완료", message: "결제 되었습니다!", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.navigationController?.popViewController(animated: true)
                self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
       
                
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
            
        }else {
            let resultAlert = UIAlertController(title: "실패", message: "결제 실패하였습니다!", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }
        
    }
   
}
