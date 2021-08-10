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
    
    var orderItem: NSArray = NSArray()
    var count: NSMutableArray = NSMutableArray()
    var timer = Timer()
    let totalTime = 4
    var secondsPassed = 0
    var receivedStoreName: String = ""
    var receivedOrderNum: String = ""
    var receivedGiftState: Bool = false
    var receivedCartState: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initSetting()
    }
    
    func initSetting() {
        storeName = ""
        ShareOrder.orderCd = ""
        ShareOrder.orderName = ""
        ShareOrder.orderCount = 0
        ShareOrder.orderPersonal = ""
        ShareOrder.orderPersonalPrice = 0
        ShareOrder.orderPrice = 0
        ShareOrder.orderImg = ""
        ShareOrder.cartOrder = false
        goOrder = false
        goCart = false
        
        self.navigationItem.hidesBackButton = true
        self.tabBarController?.tabBar.isHidden = false
        self.tvConfirmOrder.dataSource = self
        self.tvConfirmOrder.delegate = self
        self.tvConfirmOrder.separatorStyle = .none

        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        
        let orderSelectModel = OrderSelectModel()
        orderSelectModel.delegate = self
        orderSelectModel.downloadItems(receivedOrderNum)
        
        let orderCountModel = OrderCountModel()
        orderCountModel.delegate = self
        orderCountModel.downloadItems(receivedOrderNum)
        
        lblStoreName.text = "\(receivedStoreName)에서"
        lblOrderNum.text = "\(receivedOrderNum)🏃‍♀️"
        
        if receivedCartState == true {
            let cartAllDeleteModel = CartAllDeleteModel()
            let result = cartAllDeleteModel.deleteItems()
            if result {
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = false
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
        let item: OrderModel = orderItem[indexPath.row] as! OrderModel
        
        cell.lblDrinkName.text = item.name!
        cell.lblDrinkCount.text = "\(item.orderCount!) 개"
        
        let firstIndex = item.orderPersonal!.index(item.orderPersonal!.startIndex, offsetBy: 0)
        let lastIndex = item.orderPersonal!.index(item.orderPersonal!.startIndex, offsetBy: item.orderPersonal!.count-2)
        cell.lblDrinkPersonal.text = String(item.orderPersonal![firstIndex..<lastIndex])
        
        let url = URL(string: "\(item.img!)")
        let data = try? Data(contentsOf: url!)
        cell.ivConfirmOrder.layer.cornerRadius = cell.ivConfirmOrder.frame.height / 2
        cell.ivConfirmOrder.clipsToBounds = true
        cell.ivConfirmOrder.image = UIImage(data: data!)

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderItem.count
    }

}

extension ConfirmOrderViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
}

extension ConfirmOrderViewController : OrderCountModelProtocol {
    func itemDownloaded(items: NSMutableArray) {
        count = items
        let item: OrderModel = count[0] as! OrderModel
        lblTotalCount.text = "총 \(item.totalCount!) 개"
    }
}

extension ConfirmOrderViewController : OrderSelectModelProtocol {
    func orderDownloaded(items: NSArray) {
        orderItem = items
        print(orderItem.count)
        self.tvConfirmOrder.reloadData()
    }
}
