//
//  HomeEventViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/11.
//

import UIKit
import WebKit

class HomeEventViewController: UIViewController {


    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let myUrl = URL(string : "https://www.starbucks.co.kr/whats_new/campaign_view.do?pro_seq=1864")
        let myRequest = URLRequest(url: myUrl!)
        webView.load(myRequest)
        
        // Do any additional setup after loading the view.
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
