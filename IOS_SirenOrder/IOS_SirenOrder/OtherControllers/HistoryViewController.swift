//
//  HistoryViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/30.
//

import UIKit

class HistoryViewController: UIViewController {
    @IBOutlet weak var lblPeriod: UILabel!
    @IBOutlet weak var tvHistoryList: UITableView!
    @IBOutlet weak var btnPeriod: UIButton!
    
    var feedItem : NSMutableArray = NSMutableArray()
    var orderDate:Date=Date()
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
        
        tvHistoryList.rowHeight = 90
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        lblPeriod.text="\(dateFormatter.string(from: Calendar.current.date(byAdding: DateComponents(day:-30), to: Date())!)) ~ \(dateFormatter.string(from: Date()))"

        self.tvHistoryList.dataSource=self
        self.tvHistoryList.delegate=self

        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        let historyListModel = HistoryListModel()
        historyListModel.delegate=self
        historyListModel.downloadHistoryItems()
    }
    
    
    @IBAction func btnPeriod(_ sender: UIButton) {
    }
    
    @objc func updateTime(){
        let date=NSDate() // Next Step
        
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale=Locale(identifier: "ko")
        
        nowTime=date as Date
    }

}

extension HistoryViewController:HistoryModelProtocol{
    func itemDownloaded(items: NSMutableArray) {
        feedItem = items
        self.tvHistoryList.reloadData()
    }
}

extension HistoryViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if feedItem.count == 0{
//            return 1
//        }else{
//            return feedItem.count
//        }
        return feedItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item:HistoryModel = feedItem[indexPath.row] as! HistoryModel

        if feedItem.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
            cell.textLabel?.text=""
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
            cell.lblHistoryName.text="\(item.name!)"
            cell.lblHistoryDate.text="\(item.orderDate!)"
            cell.lblHistoryLocation.text="\(item.storename!)"
            cell.lblHistoryPrice.text="\(item.price!)원"

            let url = URL(string: item.img!)
            let data = try? Data(contentsOf: url!)

            cell.ivHistoryImg.layer.cornerRadius = cell.ivHistoryImg.frame.height / 2
            cell.ivHistoryImg.clipsToBounds = true
            cell.ivHistoryImg.image=UIImage(data: data!)!
            
            if indexPath.row % 2 == 0{
                cell.backgroundColor=UIColor(red: 0, green: 0, blue: 0, alpha: 0.08)
            }else{
                cell.backgroundColor=UIColor.white
            }
            

            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale=Locale(identifier: "ko")
            
            orderDate = dateFormatter.date(from: item.orderDate!)!
            
            if nowTime >= orderDate{
                cell.lblOrderComplete.isHidden=false
//                cell.ivHistoryImg.animationImages
            }else{
                cell.lblOrderComplete.isHidden=true
            }
            
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "HistoryDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvHistoryList.indexPath(for: cell)
            
            let item:HistoryModel = feedItem[indexPath!.row] as! HistoryModel
            
            let detailView = segue.destination as! HistoryDetailViewController
            detailView.receiveItems(item)
        }
    }
}


