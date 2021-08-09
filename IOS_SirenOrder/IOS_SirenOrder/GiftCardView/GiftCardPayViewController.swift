//
//  GiftCardPayViewController.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/03.
//

import UIKit

class GiftCardPayViewController: UIViewController {
    
    var checkedUser: NSArray = NSArray()
    var userSelect:(Int, String, Int) = (0,"10000",0)
    
    var sendToMe:Bool = false //나에게 보내기
    static var checkUser:Bool = false //유저 존재 확인 성공여부
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var cardNameLabel: UILabel!
    
    @IBOutlet weak var tfReceiver: UITextField!
    @IBOutlet weak var tfAddress: UITextField!
    @IBOutlet weak var tfSendMessage: UITextView!
    
    @IBOutlet weak var btnCheck: UIButton!
    
    static var cardData:(String?, String?, String?) = ("227", "커피컵","https://image.istarbucks.co.kr/cardImg/20150805/000243_WEB.png")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: GiftCardPayViewController.cardData.2!)
        let data = try? Data(contentsOf: url!)
        cardImageView.image = UIImage(data: data!)
        cardNameLabel.text =  GiftCardPayViewController.cardData.1
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnToMe(_ sender: UIButton) {
        sender.isSelected.toggle()
        if sendToMe {
            sendToMe = false
            GiftCardPayViewController.checkUser = false
            tfReceiver.isEnabled = true
            tfAddress.isEnabled = true
            btnCheck.isEnabled = true
        }else {
            tfReceiver.isEnabled = false
            tfAddress.isEnabled = false
            btnCheck.isEnabled = false
            GiftCardPayViewController.checkUser = true
            sendToMe = true
            tfReceiver.text = ""
            tfAddress.text = ""
        }
        
    }
    
    
    @IBAction func selectSendMethod(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 1:
            userSelect.0 = 1
            tfAddress.placeholder = "받는 사람 전화번호"
        default:
            userSelect.0 = 0
            tfAddress.placeholder = "받는 사람 이메일"
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
    
    @IBAction func btnCheck(_ sender: UIButton) {
        
        let receiverName = tfReceiver.text
        let receiverAddress = tfAddress.text

        if receiverName == "" || receiverAddress == "" {
            let idAleart = UIAlertController(title: "확인", message: "선물 받으실 분의 정보를 입력해주세요", preferredStyle: .alert)
            let idAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
            idAleart.addAction(idAction)
            present(idAleart, animated: true, completion: nil)
        }else {
            let giftUserCheck = GiftUserCheck()
            let userCheckResult = giftUserCheck.selectItems(giftReceiver: receiverName!, receiverAddress: receiverAddress!)
            let time = DispatchTime.now() + .seconds(1)
            DispatchQueue.main.asyncAfter(deadline: time) {
            }
            
            if userCheckResult {
                let resultAlert = UIAlertController(title: "확인", message: "존재하는 회원입니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
                GiftCardPayViewController.checkUser = true
            }else {
                let resultAlert = UIAlertController(title: "실패", message: "조회되지 않는 회원입니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
                GiftCardPayViewController.checkUser = false
            }
        }
        
    }
    @IBAction func btnGoPay(_ sender: UIButton) {

        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        print("now State \n나에게 보내기 : \(sendToMe)")
        var receiverName = tfReceiver.text
        var receiverAddress = tfAddress.text
        let sendMessage = tfSendMessage.text
        if sendToMe == false {
            if GiftCardPayViewController.checkUser == false {
                let idAleart = UIAlertController(title: "알림", message: "받으실 분의 정보를 입력하고 확인해주세요", preferredStyle: .alert)
                let idAction = UIAlertAction(title: "Yes", style: .default, handler: nil)
                idAleart.addAction(idAction)
                present(idAleart, animated: true, completion: nil)
            } else {
                let detailView = segue.destination as! GiftCardPayDetailViewController
                detailView.receiveData(receiverName!, receiverAddress!, sendMessage!, userSelect.1, userSelect.2, userSelect.0)
                
            }
        } else {
            receiverName = "\(userId)"
            receiverAddress = "\(userId)@naver.com"
            let detailView = segue.destination as! GiftCardPayDetailViewController
            detailView.receiveData(receiverName!, receiverAddress!, sendMessage!, userSelect.1, userSelect.2, userSelect.0)
        }
        
            
    
        
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    

}
