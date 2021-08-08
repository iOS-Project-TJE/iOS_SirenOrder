//
//  SignUpAuthEmailViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class SignUpAuthEmailViewController: UIViewController {

    //텍스트필드, 다음버튼
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfAuthCode: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    //이메일 정규식 확인 메시지
    @IBOutlet weak var lblEmailCheck: UILabel!
    
    //인증약관 동의버튼
    @IBOutlet weak var btnAgreeAuth: UIButton!
    @IBOutlet weak var lblAgreePersonalInfo: UILabel!
    @IBOutlet weak var btnAgreePersonalInfo: UIButton!
    @IBOutlet weak var lblAgreeUse: UILabel!
    @IBOutlet weak var btnAgreeUse: UIButton!
    
    //변수
    let sendEmailModel = SendEmailModel()
    var userEmail = ""
    var tempCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // <Back 을 < 로 바꾸기
        self.navigationController?.navigationBar.topItem?.title = ""
        setUnderLine()
        setRadius()
        
        // 화면 되돌아 왔을때 텍스트필드 지우기
        remove()
        
        // 화면 되돌아 왔을때 정규식확인메시지 지우기
        removeEmailLabel()
       
    }//viewDidLoad
    
    // 텍스트필드 지우기
    func remove(){
        tfEmail.text?.removeAll()
        tfAuthCode.text?.removeAll()
    }
    
    // 이메일 정규식확인메시지 지우기
    func removeEmailLabel(){
        lblEmailCheck.text?.removeAll()
    }

    
    //약관동의버튼 누르면 -> 아래 동의 라벨들 사라지기
    @IBAction func btnAgreeAuth(_ sender: UIButton) {
        if sender.isSelected == true{
                    lblAgreePersonalInfo.isHidden = false
                    btnAgreePersonalInfo.isHidden = false
                    lblAgreeUse.isHidden = false
                    btnAgreeUse.isHidden = false
                    btnAgreeAuth.isSelected = false
                    btnAgreeAuth.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
                }else{
                    lblAgreePersonalInfo.isHidden = true
                    btnAgreePersonalInfo.isHidden = true
                    lblAgreeUse.isHidden = true
                    btnAgreeUse.isHidden = true
                    btnAgreeAuth.isSelected = true
                    btnAgreeAuth.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                }
    }//btnAgreeAuth
    
    //이메일 정규식 체크
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }//isValidEmail
    
    //이메일 텍스트 필드와 비교
    func checkIsValidEmail() -> Bool {
        if isValidEmail(testStr: tfEmail.text!) == false {
            lblEmailCheck.text = "이메일 형식과 일치하지 않습니다."
            return false
        }
            return true
    }//checkIsValidEmail
    
    
    @IBAction func btnSendCode(_ sender: UIButton) {
        
        userEmail = String((tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
        issueTemporaryCode()
        sendTemporaryCodeToEmail()
        
    }
    
     //임시 인증코드 이메일 전송
     func sendTemporaryCodeToEmail() -> Bool{

         return sendEmailModel.sendEmail(email: userEmail, password: tempCode)

     }//sendTemporaryCode

     // 임시 인증코드 발급 - 8자리
     func issueTemporaryCode(){
         let num = 8 // 발급할 비밀번호 자릿수
         let temp = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
         
         for _ in 0..<num{
             let random = Int(arc4random_uniform(UInt32(temp.count)))
             tempCode += String(temp[temp.index(temp.startIndex, offsetBy: random)])
         }
     }//issueTemporaryCode
    
    
    //다음버튼
    @IBAction func btnNext(_ sender: UIButton) {
        //이메일 정규식메시지 지우기
        removeEmailLabel()

        // 이메일 정규식 먼저 체크
        if checkIsValidEmail() == true{
            //   인증코드 제대로 입력, 동의버튼 체크 시 넘어가기
            if tfAuthCode.text! == tempCode && btnAgreeAuth.isSelected == true {
                self.performSegue(withIdentifier: "sgToInsertIdPwd", sender: self)
                
             //  인증코드 X, 동의버튼 체크O
            }else if tfAuthCode.text! != tempCode && btnAgreeAuth.isSelected == true{
                
                let CodeAlert = UIAlertController(title: "경고", message: "인증번호가 틀렸습니다.", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                CodeAlert.addAction(onAction)
                present(CodeAlert, animated: true, completion: nil)
             
            // 인증코드 O, 동의버튼 X
            }else if tfAuthCode.text! == tempCode && btnAgreeAuth.isSelected == false {
                
                let CodeAlert = UIAlertController(title: "경고", message: "필수 항목을 동의해주세요", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                CodeAlert.addAction(onAction)
                present(CodeAlert, animated: true, completion: nil)
                
            // 인증코드 X, 동의버튼 X
            }else{
                let CodeAlert = UIAlertController(title: "경고", message: "필수항목 동의와 인증코드를 확인해주세요", preferredStyle: .alert)
                let onAction = UIAlertAction(title: "확인", style: .default, handler: nil)
                
                CodeAlert.addAction(onAction)
                present(CodeAlert, animated: true, completion: nil)
            }
            
        }
 
    }//btnNext
    
    //prepare로 입력된 이메일 값 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        userEmail = String((tfEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
        
        print("보내기\(userEmail)")

        if segue.identifier == "sgToInsertIdPwd"{

            let signInfoEmail = segue.destination as! SignUpIdPwdViewController
            signInfoEmail.receiveEmail = userEmail

        }
    }//prepare
    
    
    
    // 터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    
    
    func setUnderLine(){
         
        //이메일
        tfEmail.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tfEmail.frame.size.height-1, width: tfEmail.frame.width, height: 1)
        border.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfEmail.layer.addSublayer((border))
        tfEmail.textAlignment = .left
        tfEmail.textColor = UIColor.systemGray
        
        //패스워드
        tfAuthCode.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfAuthCode.frame.size.height-1, width: tfAuthCode.frame.width, height: 1)
        border2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfAuthCode.layer.addSublayer((border2))
        tfAuthCode.textAlignment = .left
        tfAuthCode.textColor = UIColor.systemGray
  
    }//setUnderLine
    
    func setRadius(){
        btnNext.layer.cornerRadius = 20
    }//setRadius
    
 
}//---------
