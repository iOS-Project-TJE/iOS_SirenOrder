//
//  CoverViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/07/29.
//

import UIKit

class CoverViewController: UIViewController {

    //시간설정
    let interval = 3.0 // 넘어가는 시간 설정
    let timeSelector : Selector = #selector(CoverViewController.updateTime)
    var change = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.

        //타이머준비
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
    }
    //초 시간만 불러옴
    @objc func updateTime() {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "ss"
        
        //처음3초후 시간이 뜨면 바로 넘어가게함.
        if change {
            moveNext()
        }
    }
    
    
    //넘어가는 메소드
    func moveNext() {
        //처음이 아닐경우
        if UserDefaults.standard.object(forKey: "first") != nil {
            if UserDefaults.standard.object(forKey: "userId") != nil {
                //로그인 했을경우 > 홈으로 // 자동로그인기능
                guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "TabBarVC") else{
                    return
                }

                uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

                self.present(uvc, animated: true)
            }else{
                //로그인 안했을경우 >  로그인으로
                guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") else{
                    return
                }

                uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

                self.present(uvc, animated: true)
            }
        }else {
        //처음일경우 > 퍼미션부터
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "PermissionVC") else{
            return
        }

        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

        self.present(uvc, animated: true)
            
        }
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
