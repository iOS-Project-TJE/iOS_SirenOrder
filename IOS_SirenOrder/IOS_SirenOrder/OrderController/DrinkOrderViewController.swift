//
//  DrinkOrderViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/04.
//

import UIKit

class DrinkOrderViewController: UIViewController { // 2021.08.05 조혜지 결제하기 View

    @IBOutlet weak var btnCard: UIButton!
    @IBOutlet weak var btnAccount: UIButton!
    @IBOutlet weak var btnGift: UIButton!
    @IBOutlet weak var ivCard: UIImageView!
    @IBOutlet weak var ivAccount: UIImageView!
    @IBOutlet weak var ivGift: UIImageView!
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnOrder: UIButton!
    @IBOutlet weak var tvOrder: UITableView!
    
    var dataItem: NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.barTintColor = .white
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        btnCard.layer.borderWidth = 1.5
        btnAccount.layer.borderWidth = 1.5
        btnGift.layer.borderWidth = 1.5
        
        btnCard.layer.cornerRadius = 15
        btnAccount.layer.cornerRadius = 15
        btnGift.layer.cornerRadius = 15
        btnOrder.layer.cornerRadius = 20
        
        btnCard.layer.borderColor = UIColor.systemGray5.cgColor
        btnAccount.layer.borderColor = UIColor.systemGray5.cgColor
        btnGift.layer.borderColor = UIColor.systemGray5.cgColor
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tvOrder.dataSource = self
        self.tvOrder.delegate = self
        self.tvOrder.separatorStyle = .none
        self.navigationController?.navigationBar.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
    }

    @IBAction func btnCard(_ sender: UIButton) {
        btnCard.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnAccount.layer.borderColor = UIColor.systemGray5.cgColor
        btnGift.layer.borderColor = UIColor.systemGray5.cgColor
        
        ivCard.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        ivAccount.tintColor = UIColor.darkGray
        ivGift.tintColor = UIColor.darkGray
        
        lblMessage.text = ""
    }
    
    @IBAction func btnAccount(_ sender: UIButton) {
        btnCard.layer.borderColor = UIColor.systemGray5.cgColor
        btnAccount.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        btnGift.layer.borderColor = UIColor.systemGray5.cgColor
        
        ivCard.tintColor = UIColor.darkGray
        ivAccount.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        ivGift.tintColor = UIColor.darkGray
        
        lblMessage.text = ""
    }
 
    @IBAction func btnGift(_ sender: UIButton) {
        btnCard.layer.borderColor = UIColor.systemGray5.cgColor
        btnAccount.layer.borderColor = UIColor.systemGray5.cgColor
        btnGift.layer.borderColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1).cgColor
        
        ivCard.tintColor = UIColor.darkGray
        ivAccount.tintColor = UIColor.darkGray
        ivGift.tintColor = UIColor(displayP3Red: 0/255, green: 112/225, blue: 74/255, alpha: 1)
        
        lblMessage.text = "기프트 카드 잔액 : 6,000 원"
    }
    
    func DecimalWon(value: Int) -> String{
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
            
            return result
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

extension DrinkOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! DrinkOrderTableViewCell
        
        cell.lblName.text = ShareOrder.orderName
        cell.lblCount.text = "\(ShareOrder.orderCount) 개"
        cell.lblPrice.text = DecimalWon(value: (ShareOrder.orderPrice + ShareOrder.orderPersonalPrice) * ShareOrder.orderCount)
        
        let firstIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: 0)
        let lastIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: ShareOrder.orderPersonal.count-2)
        cell.lblContent.text = String(ShareOrder.orderPersonal[firstIndex..<lastIndex])
        
        let url = URL(string: "\(ShareOrder.orderImg)")
        let data = try? Data(contentsOf: url!)
        cell.ivDrink.layer.cornerRadius = cell.ivDrink.frame.height / 2
        cell.ivDrink.clipsToBounds = true
        cell.ivDrink.image = UIImage(data: data!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}
 
extension DrinkOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

