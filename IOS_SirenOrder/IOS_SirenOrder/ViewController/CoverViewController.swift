//
//  CoverViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/07/29.
//

import UIKit

class CoverViewController: UIViewController {

    let interval = 1.0
    let timeSelector : Selector = #selector(CoverViewController.updateTime)
    var change = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
    }
    
    @objc func updateTime() {
        let formatter = DateFormatter()
        
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "ss"
        
        if change {
            moveNext()
        }else{
            change = !change
        }
    }
    
    
    func moveNext() {
        guard let uvc = self.storyboard?.instantiateViewController(withIdentifier: "PermissionVC") else{
            return
        }

        uvc.modalTransitionStyle = UIModalTransitionStyle.coverVertical

        self.present(uvc, animated: true)
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
