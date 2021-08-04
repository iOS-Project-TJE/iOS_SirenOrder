//
//  HistoryViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/30.
//

import UIKit

class HistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var lblPeriod: UILabel!
    @IBOutlet weak var tvHistoryList: UITableView!
    
    var feedItem : NSArray=NSArray()
    var receiveItem:OrderModel=OrderModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let historyList = HistoryList()
        historyList.delegate=self
        historyList.downloadItems()

        self.tvHistoryList.delegate=self
        self.tvHistoryList.dataSource=self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if feedItem.count == 0{
            return 1
        }else{
            return feedItem.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item:OrderModel = feedItem[indexPath.row] as! OrderModel
        
        if feedItem.count == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
            cell.textLabel?.text=""
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! HistoryTableViewCell
            cell.lblHistoryName.text="\(item.orderNum!)"
            cell.lblHistoryDate.text="\(item.orderDate!)"
            cell.lblHistoryLocation.text="\(item.storename!)"
            cell.ivHistoryImg.image=UIImage()
            return cell
        }
    }
    
    @IBAction func btnPeriod(_ sender: UIButton) {
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

extension HistoryViewController:HistoryListProtocol{
    func itemDownloaded(items: NSArray) {
        feedItem = items
        self.tvHistoryList.reloadData()
    }


}
