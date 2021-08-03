//
//  StoreSearchClickViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/03.
//

import UIKit

class StoreSearchClickViewController: UIViewController { // 21.08.03 조혜지 Order 매장 검색하는 View

    @IBOutlet weak var tfSearchText: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgStoreSearch" {
            let storeSearchTableViewController = segue.destination as! StoreSearchTableViewController
            storeSearchTableViewController.receivedSearchText = tfSearchText.text!
        }
    }
    

}
