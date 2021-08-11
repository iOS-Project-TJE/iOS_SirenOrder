//
//  SignUpNicNameViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class SignUpNicNameViewController: UIViewController {

    
    @IBOutlet weak var tfNickname: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    //변수: 받은아이디,패스워드,이메일
    var receiveId = ""
    var receivePw = ""
    var receiveEmail = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // <Back 을 < 로 바꾸기
        self.navigationController?.navigationBar.topItem?.title = ""
        setUnderLine()
        setRadius()
    
        remove()
        
    }//viewDidLoad
    
    func remove(){
        tfNickname.text?.removeAll()
    }
    
    //다음버튼 : 사용자 정보 DB에 입력
    @IBAction func btnNext(_ sender: UIButton) {
        let nickname = String((tfNickname.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
        if tfNickname.text?.isEmpty == false {
            let insertSignInfoModel = InsertSignInfoModel()
            let result = insertSignInfoModel.insertItems(userId: receiveId, userPw: receivePw, userNickname: nickname, userEmail: receiveEmail)
            
            if result{
                let resultAlert = UIAlertController(title: "완료", message: "가입이 완료되었습니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "확인", style: .default, handler: { ACTION in

                    self.performSegue(withIdentifier: "sgToSignUpOk", sender: self)

                })

                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)


            }else{
                let resultAlert = UIAlertController(title: "에러", message: "에러가 발생했습니다..", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "확인", style: .default, handler: { ACTION in
                })

                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)

            }
        }else{
            
            let blankAlert = UIAlertController(title: "경고", message: "닉네임을 입력해주세요", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "확인", style: .default, handler:nil)
            blankAlert.addAction(onAction)
            present(blankAlert, animated: true, completion: nil)
            
        }
        
    }//btnNext
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "sgToSignUpOk"{

            let signOkId = segue.destination as! SignUpOkViewController
          
            signOkId.receiveMsgId = receiveId

        }
    }//prepare
    

    // 터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    
    
    func setUnderLine(){
         
        //이메일
        tfNickname.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tfNickname.frame.size.height-1, width: tfNickname.frame.width, height: 1)
        border.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfNickname.layer.addSublayer((border))
        tfNickname.textAlignment = .left
        tfNickname.textColor = UIColor.systemGray
        
    }//setUnderLine
    
    func setRadius(){
        btnNext.layer.cornerRadius = 20
    }//setRadius
      

}//--------
