//
//  SignUpIdPwdViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class SignUpIdPwdViewController: UIViewController {

    //텍스트필드, 다음버튼
    @IBOutlet weak var tfUserId: UITextField!
    @IBOutlet weak var tfUserPassWord: UITextField!
    @IBOutlet weak var tfCheckPw: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    //Label: 정규식체크 메세지
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblPw: UILabel!
    @IBOutlet weak var lblCheckPw: UILabel!
    
    //비밀번호 보이기/안보이기 버튼
    @IBOutlet weak var btnSeeSecurePw: UIButton!
    
    //아이디 중복체크 dao
    let verifyDuplicatedIdModel = VerifyDuplicatedIdModel()
    
    // 변수: prepare로 받아온 email값, 넘겨줄 id,pw 값
    var userId = ""
    var userPw = ""
    var receiveEmail = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // <Back 을 < 로 바꾸기
        self.navigationController?.navigationBar.topItem?.title = ""
        setUnderLine()
        setRadius()
        
        //텍스트필드,라벨 지우기
        removeLabel()
        removeTextField()
        
    }//viewDidLoad
    
    //라벨 지우기
    func removeLabel(){
        lblId.text?.removeAll()
        lblPw.text?.removeAll()
        lblCheckPw.text?.removeAll()
    }//remove
    
    //텍스트필드 지우기
    func removeTextField(){
        tfUserId.text?.removeAll()
        tfUserPassWord.text?.removeAll()
        tfCheckPw.text?.removeAll()
    }
    
    
    // 비밀번호 시크릿모드로 보기, 눈으로 직접 확인하기
    @IBAction func btnSeeSecurePw(_ sender: UIButton) {
        if sender.isSelected == false {
            btnSeeSecurePw.isSelected = true
            btnSeeSecurePw.setImage(UIImage(systemName: "eye" ), for: .normal)
            tfUserPassWord.isSecureTextEntry = false
            tfCheckPw.isSecureTextEntry = false
        }else{
            btnSeeSecurePw.isSelected = false
            btnSeeSecurePw.setImage(UIImage(systemName: "eye.slash" ), for: .normal)
            tfUserPassWord.isSecureTextEntry = true
            tfCheckPw.isSecureTextEntry = true
        }
    }//btnSeeSecurePw
    
    // 아이디 정규식 체크
    func isValidId(id: String) -> Bool {
        let idReg = "^[a-zA-Z0-9]{4,13}$"
        let idTesting = NSPredicate(format: "SELF MATCHES %@", idReg)
        return idTesting.evaluate(with: id)
    }//isValidId

    //패스워드 정규식 체크
    func isValidPw(mypassword : String) -> Bool {
        //숫자+문자 포함해서 5~20글자 사이의 text 체크하는 정규표현식
        let passwordReg = ("^[a-zA-Z0-9]{5,20}$")//String 프로퍼티에 정규식 사용
        let passwordTesting = NSPredicate(format: "SELF MATCHES %@", passwordReg)//프로퍼티 초기화
        return passwordTesting.evaluate(with: mypassword)
        
    }//isValidPw
    
    
    //비밀번호 확인 체크
    func checkPw() -> Bool{
        if tfUserPassWord.text! == tfCheckPw.text!{
            lblCheckPw.text = "비밀번호가 일치합니다."
            return true
        }else{
            lblCheckPw.text = "비밀번호가 일치하지 않습니다."
            return false
        }
    }//checkPw
    
    //아이디 텍스트 필드와 비교
    func checkIsValidId() -> Bool {
        if isValidId(id: tfUserId.text!) == false{
            lblId.text = "아이디는 4~13자의 영문자와 숫자로 입력해야 합니다."
            return false
        }
            return true
    }//checkIsValidId
    
    //비밀번호 텍스트 필드와 비교
    func checkIsValidPw() -> Bool {
        if isValidPw(mypassword: tfUserPassWord.text!) == false {
            lblPw.text = "패스워드는 5~20자의 문자와 숫자로 입력해야 합니다."
            return false
        }
            return true
    }//checkIsValidPw
    

    @IBAction func btnNext(_ sender: UIButton) {
        
        removeLabel()//label 빈칸

        if checkIsValidId() == true && checkIsValidPw() == true && checkPw() == true {
            
            userId = String((tfUserId.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
            verifyDuplicatedIdModel.delegate = self
            verifyDuplicatedIdModel.downloadItems(subUrl: userId)
        }
    }//btnNext
    
    //입력된 아이디와 패스워드 넘기기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        

        userId = String((tfUserId.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
        userPw = String((tfUserPassWord.text?.trimmingCharacters(in: .whitespacesAndNewlines))!)
        
        if segue.identifier == "sgToNickName"{

            let signInfo = segue.destination as! SignUpNicNameViewController
            //signInfo.receiveInfo(userId: userId, userPw: userPw)
            signInfo.receiveId = userId
            signInfo.receivePw = userPw
            signInfo.receiveEmail = receiveEmail

        }
    }//prepare
    

    
    // 터치
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    
    
    func setUnderLine(){
         
        //이메일
        tfUserId.borderStyle = .none
        let border = CALayer()
        border.frame = CGRect(x: 0, y: tfUserId.frame.size.height-1, width: tfUserId.frame.width, height: 1)
        border.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfUserId.layer.addSublayer((border))
        tfUserId.textAlignment = .left
        tfUserId.textColor = UIColor.systemGray
        
        //패스워드
        tfUserPassWord.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfUserPassWord.frame.size.height-1, width: tfUserPassWord.frame.width, height: 1)
        border2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfUserPassWord.layer.addSublayer((border2))
        tfUserPassWord.textAlignment = .left
        tfUserPassWord.textColor = UIColor.systemGray
        
        //패스워드 확인
        tfCheckPw.borderStyle = .none
        let border3 = CALayer()
        border3.frame = CGRect(x: 0, y: tfCheckPw.frame.size.height-1, width: tfCheckPw.frame.width, height: 1)
        border3.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfCheckPw.layer.addSublayer((border3))
        tfCheckPw.textAlignment = .left
        tfCheckPw.textColor = UIColor.systemGray
        
    }//setUnderLine
    
    func setRadius(){
        btnNext.layer.cornerRadius = 20
    }//setRadius
    
}//---------

extension SignUpIdPwdViewController : VerifyDuplicatedIdProtocol{

    func itemDownloaded(items: String) {
        if items == "0"{
            //일치하는 아이디가 없다면!
            self.performSegue(withIdentifier: "sgToNickName", sender: self)

            
        }else{
            //일치하는 아이디가 있다면
            let duplicateAlert = UIAlertController(title: "경고", message: "중복된 아이디입니다.", preferredStyle: .alert)
            let onAction = UIAlertAction(title: "확인", style: .default, handler: nil)

            duplicateAlert.addAction(onAction)
            present(duplicateAlert, animated: true, completion: nil)

            
        }
    }
  
}//extension
