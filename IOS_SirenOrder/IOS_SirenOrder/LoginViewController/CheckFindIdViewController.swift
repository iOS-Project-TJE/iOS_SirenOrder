//
//  CheckFindIdViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class CheckFindIdViewController: UIViewController {

    
    
    @IBOutlet weak var lblCheckId: UILabel!
    @IBOutlet weak var btnLogin: UIButton!
    
    //변수: 받은 아이디
    var sendId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.topItem?.title = ""
        lblCheckId.text = "고객님의 아이디는 \(sendId) 입니다."
    
        setRadius()
        
    }//viewDidLoad
    
    
    
    //로그인 : 네비처음화면
    @IBAction func btnLogin(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    func setRadius(){
        btnLogin.layer.cornerRadius = 20
    }

    
    
    

}//-------
