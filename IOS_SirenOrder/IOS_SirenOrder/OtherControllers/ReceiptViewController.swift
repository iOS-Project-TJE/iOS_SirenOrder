//
//  ReceiptViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/30.
//

import UIKit

class ReceiptViewController: UIViewController {
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblPeriod: UILabel!
    @IBOutlet weak var btnPeriod: UIButton!
    @IBOutlet weak var tvReceiptList: UITableView!
    
    var feedItem : NSMutableArray = NSMutableArray()
    var orderCount=0
    var priceCount=0
    
    var nowTime:Date=Date()
    
    let interval=1.0
    let timeSelector:Selector=#selector(HistoryViewController.updateTime)
    
    let dateFormatter=DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        
        btnPeriod.layer.cornerRadius = 10
        btnPeriod.layer.borderWidth = 1.2
        btnPeriod.layer.borderColor = UIColor.brown.cgColor
        
        tvReceiptList.rowHeight = 55
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        lblPeriod.text="\(dateFormatter.string(from: Calendar.current.date(byAdding: DateComponents(day:-30), to: Date())!)) ~ \(dateFormatter.string(from: Date()))"

        self.tvReceiptList.dataSource=self
        self.tvReceiptList.delegate=self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        priceCount=0
        let receiptListModel = ReceiptListModel()
        receiptListModel.delegate=self
        receiptListModel.downloadReceiptItems()
        self.tvReceiptList.reloadData()
    }

    @objc func updateTime(){
        let date=NSDate() // Next Step
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale=Locale(identifier: "ko")
        
        nowTime=date as Date
    }

}

extension ReceiptViewController:ReceiptModelProtocol{
    func itemDownloaded(items: NSMutableArray) {
        feedItem = items
        self.tvReceiptList.reloadData()
    }
}

extension ReceiptViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if feedItem.count == 0{
//            return 1
//        }else{
//            return feedItem.count
//        }
        lblCount.text = "\(feedItem.count)건"
        priceCount=0
        
        for i in 0..<feedItem.count{
            let item=feedItem[i] as! ReceiptModel
            
            priceCount += item.price!
        }
        
        lblPrice.text = "\(priceCount)원"
        
        return feedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item:ReceiptModel = feedItem[indexPath.row] as! ReceiptModel

        if feedItem.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath)
            cell.textLabel?.text=""
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "receiptCell", for: indexPath) as! ReceiptTableViewCell
            cell.lblOrderDate.text="\(item.orderDate!)"
            cell.lblLocation.text="\(item.storename!)"
            cell.lblOrderPrice.text="\((item.orderCount! * item.price!) + (item.orderCount! * item.orderPersonalPrice!))원"
            
            cell.selectionStyle = .none

            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ReceiptDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvReceiptList.indexPath(for: cell)
            
            let item:ReceiptModel = feedItem[indexPath!.row] as! ReceiptModel
            
            let detailView = segue.destination as! ReceiptDetailViewController
            detailView.receiveItems(item)
        }
    }
}

