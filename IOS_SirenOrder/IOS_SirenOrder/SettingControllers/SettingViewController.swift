//
//  SettingViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/08/07.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var btnMemberDelete: UIButton!
    @IBOutlet weak var swPush: UISwitch!
    @IBOutlet weak var swLocation: UISwitch!
    
    let green:UIColor=#colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnLogout.layer.cornerRadius = 10
        btnLogout.layer.borderWidth = 1.2
        btnLogout.layer.borderColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)

    }
    
    @IBAction func btnLogout(_ sender: UIButton) {
        let testAlert=UIAlertController(title: "로그아웃 하시겠어요?", message: nil, preferredStyle: .alert)
        
        let actionDefault=UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            userId = ""
            UserDefaults.standard.removeObject(forKey: "userId")
            
            guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "CoverVC") else{
                return
            }

            uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

            self.present(uvc, animated: true)
            
        })
        let actionCanceled=UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionDefault.setValue(green, forKey: "titleTextColor")
        actionCanceled.setValue(green, forKey: "titleTextColor")
        
        testAlert.addAction(actionDefault)
        testAlert.addAction(actionCanceled)
        
        present(testAlert, animated: true, completion: nil)
    }
    
    @IBAction func btnMemberDelete(_ sender: UIButton) {
        let testAlert=UIAlertController(title: "회원 탈퇴는 홈페이지에서 가능합니다.", message: nil, preferredStyle: .alert)
        
        let actionDefault=UIAlertAction(title: "확인", style: .default, handler: {ACTION in
            self.performSegue(withIdentifier: "memberDelete", sender: self)
        })
        let actionCanceled=UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        actionDefault.setValue(green, forKey: "titleTextColor")
        actionCanceled.setValue(green, forKey: "titleTextColor")
        
        testAlert.addAction(actionDefault)
        testAlert.addAction(actionCanceled)
        
        present(testAlert, animated: true, completion: nil)
    }
    
    @IBAction func btnVersion(_ sender: UIButton) {
        self.performSegue(withIdentifier: "versionDetail", sender: self)
    }
    
    @IBAction func btnLocation(_ sender: UIButton) {
        self.performSegue(withIdentifier: "locationPermission", sender: self)
    }
    
    @IBAction func swPush(_ sender: UISwitch) {
    }
    
    
    @IBAction func swLocation(_ sender: UISwitch) {
    }
}
