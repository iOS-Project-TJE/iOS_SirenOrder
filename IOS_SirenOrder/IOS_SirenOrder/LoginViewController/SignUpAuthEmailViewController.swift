//
//  SignUpAuthEmailViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class SignUpAuthEmailViewController: UIViewController {

    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPwd: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // <Back 을 < 로 바꾸기
        self.navigationController?.navigationBar.topItem?.title = ""
        setUnderLine()
        setRadius()
       
    }
    

    
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        //버튼눌렀을때 id password 입력창으로
          self.performSegue(withIdentifier: "sgToInsertIdPwd", sender: self)
    }
    
    
    
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
        tfPwd.borderStyle = .none
        let border2 = CALayer()
        border2.frame = CGRect(x: 0, y: tfPwd.frame.size.height-1, width: tfPwd.frame.width, height: 1)
        border2.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfPwd.layer.addSublayer((border2))
        tfPwd.textAlignment = .left
        tfPwd.textColor = UIColor.systemGray
        
        
        
    }
    
    func setRadius(){
        btnNext.layer.cornerRadius = 20
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
