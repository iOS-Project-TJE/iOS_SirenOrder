//
//  SignUpAgreeViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class SignUpAgreeViewController: UIViewController {

    
    
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRadius()
        // Do any additional setup after loading the view.
    }
    

    
    
    
    @IBAction func btnNext(_ sender: UIButton) {
        
            // 버튼 눌렀을때 해당 segue로 가게 하겠다.
            self.performSegue(withIdentifier: "sgToAuthEmail", sender: self)
    
    }
    
    
    
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
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
