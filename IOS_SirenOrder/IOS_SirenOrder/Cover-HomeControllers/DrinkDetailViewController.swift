//
//  DrinkDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/03.
//

import UIKit

class DrinkDetailViewController: UIViewController {

    @IBOutlet weak var lblCdCheck: UILabel!
    
    var receivedCd: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblCdCheck.text = receivedCd
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "sgPersonal" {
            let orderPersonalViewController = segue.destination as! OrderPersonalViewController
            orderPersonalViewController.receivedCd = receivedCd
        }
    }
    

}
