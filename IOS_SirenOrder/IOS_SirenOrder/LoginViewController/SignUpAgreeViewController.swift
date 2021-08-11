//
//  SignUpAgreeViewController.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/01.
//

import UIKit

class SignUpAgreeViewController: UIViewController {

    //이용약관 전체 동의
    @IBOutlet weak var btnAgreeAll: UIButton!
    //이용약관
    @IBOutlet weak var btnAgreeUse: UIButton!
    //개인정보 약관버튼
    @IBOutlet weak var btnAgreePersonalInfo: UIButton!
    // Email- 광고성정보
    @IBOutlet weak var btnAgreeAd: UIButton!
    //다음버튼
    @IBOutlet weak var btnNext: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.title = ""
        setRadius()
        
    }//viewDidLoad
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //전체약관동의
    @IBAction func btnAgreeAll(_ sender: UIButton) {
        
        if sender.isSelected == false {
            
            btnAgreeAll.isSelected = true
            btnAgreeAll.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            
            btnAgreeUse.isSelected = true
            btnAgreeUse.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)

            btnAgreePersonalInfo.isSelected = true
            btnAgreePersonalInfo.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)

            btnAgreeAd.isSelected = true
            btnAgreeAd.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)

        }else{
            
            btnAgreeAll.isSelected = false
            btnAgreeAll.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            

            btnAgreeUse.isSelected = false
            btnAgreeUse.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
            btnAgreePersonalInfo.isSelected = false
            btnAgreePersonalInfo.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
            btnAgreeAd.isSelected = false
            btnAgreeAd.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
        }
   
    }// btnAgreeAll
    
    
    // 이용약관동의 (필)
    @IBAction func btnAgreeUse(_ sender: UIButton) {
        // 누르면 이미지가 채워지는 것으로 변경!
        if sender.isSelected == true {
            btnAgreeUse.isSelected = false
            btnAgreeUse.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            
        }else {
            btnAgreeUse.isSelected = true
            btnAgreeUse.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)

        }
    }//btnAgreeUse
    
    
    //개인정보 수집 및 이용동의 (필)
    @IBAction func btnAgreePersonalInfo(_ sender: UIButton) {
        if sender.isSelected == true{
            btnAgreePersonalInfo.isSelected = false
            btnAgreePersonalInfo.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }else{
            btnAgreePersonalInfo.isSelected = true
            btnAgreePersonalInfo.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
  
    }//btnAgreePersonalInfo
    
    //광고성 정보 수신 동의(선택)
    
    @IBAction func btnAgreeAd(_ sender: UIButton) {
        if sender.isSelected == true{
            btnAgreeAd.isSelected = false
            btnAgreeAd.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        }else{
            btnAgreeAd.isSelected = true
            btnAgreeAd.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
        }
    }//btnAgreeAd
    
    
  
    @IBAction func btnNext(_ sender: UIButton) {
        
        if btnAgreeUse.isSelected == true && btnAgreePersonalInfo.isSelected == true{
            // 버튼 눌렀을때 해당 segue로 가게 하겠다.
            if btnAgreeAd.isSelected == false{
                let agreeAlert = UIAlertController(title: "확인", message: "광고성 정보 수집 동의를 거부하였습니다.", preferredStyle: .alert)
                let agreeAction = UIAlertAction(title: "확인", style: .default, handler: {ACTION in
                    self.performSegue(withIdentifier: "sgToAuthEmail", sender: self)

                })
                
                agreeAlert.addAction(agreeAction)
                present(agreeAlert, animated: true, completion: nil)
            }else{
                self.performSegue(withIdentifier: "sgToAuthEmail", sender: self)

            }
            
        }else{
            //불일치시
            let agreeAlert = UIAlertController(title: "경고", message: "필수 이용약관을 체크해 주세요!", preferredStyle: .alert)
            let agreeAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            agreeAlert.addAction(agreeAction)
            present(agreeAlert, animated: true, completion: nil)
        }

    }//btnNext
    
    //---------------------- 뷰 꾸미는 속성 (텍스트필드, 버튼)
    func setRadius(){
        btnNext.layer.cornerRadius = 20
    }
    
}//----------
