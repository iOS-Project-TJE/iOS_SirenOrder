//
//  ResetPassWordViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class ResetPassWordViewController: UIViewController {

    //비밀번호 변경 메세지
    @IBOutlet weak var lblMessage: UILabel!
    
    //텍스트필드와 버튼
    @IBOutlet weak var tfNewPw: UITextField!
    @IBOutlet weak var tfNewPwCheck: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var btnSeeSecurePw: UIButton!
    
    //정규식,비밀번호일치여부 라벨
    @IBOutlet weak var lblPw: UILabel!
    @IBOutlet weak var lblCheckPw: UILabel!
    
    //변수 : 받은 아이디
    var sendId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        remove()
        self.navigationController?.navigationBar.topItem?.title = ""
        setUnderLine()
        setRadius()
        
        
        //메세지 창에 현재 아이디
        lblMessage.text = "\(sendId)님의 비밀번호를 변경합니다."

    }//viewDidLoad
    
    //라벨 클리어
    func remove(){
        lblPw.text = ""
        lblCheckPw.text = ""
    }//remove

    
    
    @IBAction func btnSeeSecurePw(_ sender: UIButton) {
        if sender.isSelected == false {
            btnSeeSecurePw.isSelected = true
            btnSeeSecurePw.setImage(UIImage(systemName: "eye" ), for: .normal)
            tfNewPw.isSecureTextEntry = false
            tfNewPwCheck.isSecureTextEntry = false
        }else{
            btnSeeSecurePw.isSelected = false
            btnSeeSecurePw.setImage(UIImage(systemName: "eye.slash" ), for: .normal)
            tfNewPw.isSecureTextEntry = true
            tfNewPwCheck.isSecureTextEntry = true

        }

    }//btnSeeSecure
    
    
    //패스워드 정규식 체크
    func isValidPw(mypassword : String) -> Bool {
        //숫자+문자 포함해서 5~20글자 사이의 text 체크하는 정규표현식
        let passwordReg = ("^[a-zA-Z0-9]{5,20}$")//String 프로퍼티에 정규식 사용
        let passwordTesting = NSPredicate(format: "SELF MATCHES %@", passwordReg)//프로퍼티 초기화
        return passwordTesting.evaluate(with: mypassword)
        
    }//isValidPw
    
    
    //비밀번호 텍스트 필드와 비교
    func checkIsValidPw() -> Bool {
        if isValidPw(mypassword: tfNewPw.text!) == false {
            lblPw.text = "패스워드는 5~20자의 문자와 숫자로 입력해야 합니다."
            return false
        }
            return true
    }//checkIsValidPw
    
    //비밀번호 확인 체크
    func checkPw() -> Bool{
        if tfNewPw.text! == tfNewPwCheck.text!{
            lblCheckPw.text = "비밀번호가 일치합니다."
            return true
        }else{
            lblCheckPw.text = "비밀번호가 일치하지 않습니다."
            return false
        }
    }//checkPw
    

    
    
    @IBAction func btnNext(_ sender: UIButton) {
        remove()

        //해당 이메일의 아이디의 패스워드를 업데이트!
        //비밀번호가 변경되었습니다 얼러트 뜨고 로그인 화면으로 돌아가기!

        let userPw = tfNewPw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if checkIsValidPw() == true && checkPw() == true{
            //self.performSegue(withIdentifier: "sgToNickName", sender: self)
            let changePw = ChangePwModel()
            let result = changePw.changePwItems(password: userPw, id: sendId)
           
            if result{
                let resultAlert = UIAlertController(title: "완료", message: "비밀번호가 변경되었습니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "확인", style: .default, handler: { ACTION in
                    self.navigationController?.popToRootViewController(animated: true)
                })
                
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)
           
            }else{
                let resultAlert = UIAlertController(title: "에러", message: "비밀번호 변경이 불가합니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "확인", style: .default, handler: { ACTION in
                })
                
                resultAlert.addAction(onAction)
                present(resultAlert, animated: true, completion: nil)

            }
        }
    }//btnNext
    
    // 터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    func setUnderLine(){
         
        //새로운 비밀번호
        tfNewPw.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tfNewPw.frame.size.height-1, width: tfNewPw.frame.width, height: 1)
        border.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfNewPw.layer.addSublayer((border))
        tfNewPw.textAlignment = .left
        tfNewPw.textColor = UIColor.systemGray
    
        
        
        //새로운 비밀번호 확인
        tfNewPwCheck.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfNewPwCheck.frame.size.height-1, width: tfNewPwCheck.frame.width, height: 1)
        border2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfNewPwCheck.layer.addSublayer((border2))
        tfNewPwCheck.textAlignment = .left
        tfNewPwCheck.textColor = UIColor.systemGray
        
    }//setUnderLine
        
        
    func setRadius(){
        btnNext.layer.cornerRadius = 20
    }//setRadius
    
}//----------
