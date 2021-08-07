//
//  MemberDeleteViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/08/07.
//

import UIKit
import WebKit

class MemberDeleteViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myUrl = URL(string : "https://www.starbucks.co.kr:7643/my/myinfo_out.do")
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
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
