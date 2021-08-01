//
//  SignUpIdPwdViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class SignUpIdPwdViewController: UIViewController {

    
    @IBOutlet weak var tfUserId: UITextField!
    @IBOutlet weak var tfUserPassWord: UITextField!
    @IBOutlet weak var tfCheckPwd: UITextField!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // <Back 을 < 로 바꾸기
        self.navigationController?.navigationBar.topItem?.title = ""
        setUnderLine()
        setRadius()
    }
    

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
        tfCheckPwd.borderStyle = .none
        let border3 = CALayer()
        border3.frame = CGRect(x: 0, y: tfCheckPwd.frame.size.height-1, width: tfCheckPwd.frame.width, height: 1)
        border3.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        tfCheckPwd.layer.addSublayer((border3))
        tfCheckPwd.textAlignment = .left
        tfCheckPwd.textColor = UIColor.systemGray
        
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
