//
//  SignUpOkViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/08.
//

import UIKit

class SignUpOkViewController: UIViewController {

    //받은id
    var receiveMsgId = ""

    @IBOutlet weak var lblWelcomeMsg: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        setRadius()
        
        lblWelcomeMsg.text = "\(receiveMsgId)님, 회원가입이 완료되었습니다."
       
    }//viewDidLoad
    

    @IBAction func btnNext(_ sender: UIButton) {
        //네비게이션의처음: 로그인화면으로 돌아가기
         self.navigationController?.popToRootViewController(animated: true)
    }
    
    func setRadius(){
        btnNext.layer.cornerRadius = 20
    }//setRadius


}//--------
