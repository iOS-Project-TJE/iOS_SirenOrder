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
    let totalTime = 4
    var secondsPassed = 0
    var dataItem: NSArray = NSArray()
    var count: NSMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = false
        self.tvConfirmOrder.dataSource = self
        self.tvConfirmOrder.delegate = self
        self.tvConfirmOrder.separatorStyle = .none

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        let cartSelectModel = CartSelectModel()
        cartSelectModel.delegate = self
        cartSelectModel.downloadItems()
        
        if ShareOrder.cartOrder == false {
            lblTotalCount.text = "총 \(ShareOrder.orderCount) 개"
        }else {
            let cartCountModel = CartCountModel()
            cartCountModel.delegate = self
            cartCountModel.downloadItems()
        }
    }
    
    @objc func updateTime() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        }else {
            timer.invalidate()
        }
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

extension ConfirmOrderViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "confirmOrderCell") as! ConfirmOrderTableViewCell

        if ShareOrder.cartOrder == false {
            cell.lblDrinkName.text = ShareOrder.orderName
            cell.lblDrinkCount.text = "\(ShareOrder.orderCount) 개"

            let firstIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: 0)
            let lastIndex = ShareOrder.orderPersonal.index(ShareOrder.orderPersonal.startIndex, offsetBy: ShareOrder.orderPersonal.count-2)
            cell.lblDrinkPersonal.text = String(ShareOrder.orderPersonal[firstIndex..<lastIndex])

            let url = URL(string: "\(ShareOrder.orderImg)")
            let data = try? Data(contentsOf: url!)
            cell.ivConfirmOrder.layer.cornerRadius = cell.ivConfirmOrder.frame.height / 2
            cell.ivConfirmOrder.clipsToBounds = true
            cell.ivConfirmOrder.image = UIImage(data: data!)
        }else {
            let item: CartModel = dataItem[indexPath.row] as! CartModel
            cell.lblDrinkName.text = item.name!
            cell.lblDrinkCount.text = "\(item.cartCount!) 개"

            let firstIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: 0)
            let lastIndex = item.cartPersonal!.index(item.cartPersonal!.startIndex, offsetBy: item.cartPersonal!.count-2)
            cell.lblDrinkPersonal.text = String(item.cartPersonal![firstIndex..<lastIndex])

            let url = URL(string: "\(item.img!)")
            let data = try? Data(contentsOf: url!)
            cell.ivConfirmOrder.layer.cornerRadius = cell.ivConfirmOrder.frame.height / 2
            cell.ivConfirmOrder.clipsToBounds = true
            cell.ivConfirmOrder.image = UIImage(data: data!)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ShareOrder.cartOrder == false {
            return 1
        }else {
            return dataItem.count
        }
    }

}

extension ConfirmOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}

extension ConfirmOrderViewController : CartSelectModelProtocol {
    func cartItemDownloaded(items: NSArray) {
        dataItem = items
        self.tvConfirmOrder.reloadData()
    }
}

extension ConfirmOrderViewController : CartCountModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        count = items
        let item: PersonalModel = count[0] as! PersonalModel
        lblTotalCount.text = "총 \(item.cartCount!) 개"
    }
}
