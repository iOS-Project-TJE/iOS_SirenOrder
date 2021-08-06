//
//  ConfirmOrderViewController.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/06.
//

import UIKit

class ConfirmOrderViewController: UIViewController { // 21.08.06 조혜지 결제 후 결제 정보 확인하는 View

    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var lblOrderNum: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var lblTotalCount: UILabel!
    @IBOutlet weak var tvConfirmOrder: UITableView!
    
    var timer = Timer()
    let totalTime = 3
    var secondsPassed = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = false
//        self.tvConfirmOrder.dataSource = self
//        self.tvConfirmOrder.delegate = self
//        self.tvConfirmOrder.separatorStyle = .none

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        }else {
            timer.invalidate()
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

//extension ConfirmOrderViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! DrinkOrderTableViewCell
//        
//        if ShareOrder.cartOrder == false {
//            cell.lblName.text = ShareOrder.orderName
//            cell.lblCount.text = "\(ShareOrder.orderCount) 개"
//            cell.lblPrice.text = DecimalWon(value: (ShareOrder.orderPrice + ShareOrder.orderPersonalPrice) * ShareOrder.orderCount)
//            
//            let firstIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: 0)
//            let lastIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: ShareOrder.orderPersonal.count-2)
//            cell.lblContent.text = String(ShareOrder.orderPersonal[firstIndex..<lastIndex])
//            
//            let url = URL(string: "\(ShareOrder.orderImg)")
//            let data = try? Data(contentsOf: url!)
//            cell.ivDrink.layer.cornerRadius = cell.ivDrink.frame.height / 2
//            cell.ivDrink.clipsToBounds = true
//            cell.ivDrink.image = UIImage(data: data!)
//        }else {
//            let item: CartModel = dataItem[indexPath.row] as! CartModel
//            cell.lblName.text = item.name!
//            cell.lblCount.text = "\(item.cartCount!) 개"
//            cell.lblPrice.text = DecimalWon(value: (item.price! + item.cartPersonalPrice!) * item.cartCount!)
//            
//            let firstIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: 0)
//            let lastIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: item.cartPersonal!.count-2)
//            cell.lblContent.text = String(item.cartPersonal![firstIndex..<lastIndex])
//            
//            let url = URL(string: "\(item.img!)")
//            let data = try? Data(contentsOf: url!)
//            cell.ivDrink.layer.cornerRadius = cell.ivDrink.frame.height / 2
//            cell.ivDrink.clipsToBounds = true
//            cell.ivDrink.image = UIImage(data: data!)
//        }
//        
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if ShareOrder.cartOrder == false {
//            return 1
//        }else {
//            return dataItem.count
//        }
//    }
//
//}
// 
//extension ConfirmOrderViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 170
//    }
//}
