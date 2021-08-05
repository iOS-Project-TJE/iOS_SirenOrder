//
//  CartViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/04.
//

import UIKit

class CartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func btnAllDelete(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func btnOrder(_ sender: UIButton) {
        goOrder = true
        if storeName == "" {
            let resultAlert = UIAlertController(title: "주문할 매장을 선택해 주세요!", message: nil, preferredStyle: .alert)
            let onAction = UIAlertAction(title: "OK", style: .default, handler: {ACTION in
                self.performSegue(withIdentifier: "sgStoreChoice", sender: self)
            })
            resultAlert.addAction(onAction)
            present(resultAlert, animated: true, completion: nil)
        }else {
            self.performSegue(withIdentifier: "sgOrder", sender: self)
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
