//
//  LoginViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class LoginViewController: UIViewController {

    
    
    @IBOutlet weak var tfUserId: UITextField!
    @IBOutlet weak var tfUserPassWord: UITextField!

    @IBOutlet weak var btnLogin: UIButton!
    
    
    var feedItem: NSMutableArray = NSMutableArray()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //텍스트필드 지우기
        remove()
        
        //textField 밑줄로 만들기
        setUnderLineId()
        setUnderLinePwd()
        
        //버튼 라운드
        setRadius()
        

//        if UserDefaults.standard.object(forKey: "userId") != nil { // UserDefault에 값이 있다
//            //ShareVar.userId ?
//            userId = UserDefaults.standard.object(forKey: "userId") as! String
//            self.performSegue(withIdentifier: "sgLoginToMain", sender: self) //Main으로 가는 sg만들기
//
//        }else{

            // 없으면 불러오기!
            doQueryModel()

//        }//if

    }//viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        remove()
    }
    
    func remove(){
        tfUserId.text?.removeAll()
        tfUserPassWord.text?.removeAll()
    }
    
    //query Model 실행
    func doQueryModel(){
        let userinfoModel = UserInfoModel()
        userinfoModel.delegate = self
        userinfoModel.downloadItems()
        
    }//
    
   
  
    //로그인 버튼
    @IBAction func btnLogin(_ sender: UIButton) {
        var count: Int = 0
        
        for i in 0..<feedItem.count {
            let item: LoginUserInfoModel = feedItem[i] as! LoginUserInfoModel
            guard let id = item.userId else {
                return
            }
            guard let password = item.userPw else {
                return
            }
            
            if tfUserId.text == id && tfUserPassWord.text == password {
                // 아이디와 비밀번호가 일치하면
                count += 1
                //sharvar의 userId 에 넣어주기
                userId = tfUserId.text!
                UserDefaults.standard.set(tfUserId.text!, forKey: "userId")

                self.performSegue(withIdentifier: "sgLoginToHome", sender: self)
                
            } // if
            
        } // for
        
        if count == 0 {
        //불일치시
        let idAlert = UIAlertController(title: "경고", message: "ID나 암호가 불일치 합니다!", preferredStyle: .alert)
        let idAction = UIAlertAction(title: "확인", style: .default, handler: nil)
 
        idAlert.addAction(idAction)
        present(idAlert, animated: true, completion: nil)

        }//if

    }//btnLogin
    

    // 아이디 찾기 버튼
    @IBAction func btnFindUserId(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "sgFindUserId", sender: self)

    }
    
 
    //회원가입 버튼
    @IBAction func btnSignUp(_ sender: UIButton) {
    
        self.performSegue(withIdentifier: "sgLoginToSignUp", sender: self)
        
    }//btnSignUp
    
    
    // 비밀번호 찾기
    @IBAction func btnFindUserPw(_ sender: UIButton) {
        
        self.performSegue(withIdentifier: "sgToFindUserPw", sender: self)

    }//btnFindUserPw
    

    
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    func setUnderLineId(){
        
        tfUserId.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tfUserId.frame.size.height-1, width: tfUserId.frame.width, height: 1)
        border.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfUserId.layer.addSublayer((border))
        tfUserId.textAlignment = .left
        tfUserId.textColor = UIColor.systemGray
    }
    
    func setUnderLinePwd(){
        
        tfUserPassWord.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfUserPassWord.frame.size.height-1, width: tfUserPassWord.frame.width, height: 1)
        border2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfUserPassWord.layer.addSublayer((border2))
        tfUserPassWord.textAlignment = .left
        tfUserPassWord.textColor = UIColor.systemGray
    }
    
    
    func setRadius(){
        btnLogin.layer.cornerRadius = 20
    }
    
    //터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}//---------

extension LoginViewController: UserInfoModelProtocol{
    func itemDownloaded(items: NSArray) {  
        feedItem = items as! NSMutableArray
    }
}//extension
