//
//  SearchViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/08.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tfSearch: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sgSearch" {
            let searchDetailViewController = segue.destination as! SearchDetailViewController
            searchDetailViewController.receivedName = tfSearch.text!
            
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
