//
//  ReceiptViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/30.
//

import UIKit

class ReceiptViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
