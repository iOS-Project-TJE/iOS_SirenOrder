//
//  HistoryDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/08/03.
//

import UIKit

class HistoryDetailViewController: UIViewController {
    @IBOutlet weak var lblOrderNum: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblOrderDate2: UILabel!
    @IBOutlet weak var lblOrderDate3: UILabel!
    @IBOutlet weak var lblOrderFin: UILabel!
    @IBOutlet weak var lblOrderLoc: UILabel!
    @IBOutlet weak var lblOrderLoc2: UILabel!
    @IBOutlet weak var lblOrderLoc3: UILabel!
    @IBOutlet weak var lblOrderLoc4: UILabel!
    @IBOutlet weak var lblOrderLocDetail: UILabel!
    @IBOutlet weak var lblDrinkName: UILabel!
    @IBOutlet weak var lblOrderPersonal: UILabel!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var orderPerm: UIView!
    @IBOutlet weak var orderReady: UIView!
    @IBOutlet weak var viewSection1: UIView!
    
    
    var receiveItem:HistoryModel=HistoryModel()
    var orderDate:Date=Date()
    var nowTime:Date=Date()
    
    let interval=1.0
    let timeSelector:Selector=#selector(HistoryDetailViewController.updateTime)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.sendSubviewToBack(self.viewSection1)
        
        dateChange()
        
        Timer.scheduledTimer(timeInterval: interval, target: self, selector: timeSelector, userInfo: nil, repeats: true)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        
        if receiveItem.orderPersonal == "null"{
            lblOrderPersonal.text = ""
        }else{
            let firstIndex = receiveItem.orderPersonal!.index(receiveItem.orderPersonal!.startIndex, offsetBy: 0)
            let lastIndex = receiveItem.orderPersonal!.index(receiveItem.orderPersonal!.startIndex, offsetBy: receiveItem.orderPersonal!.count-2)
            lblOrderPersonal.text = String(receiveItem.orderPersonal![firstIndex..<lastIndex])
        }
        
        lblOrderFin.text="\(dateFormatter.string(from: Date(timeInterval: 300, since: orderDate)))"

        lblOrderNum.text="주문 번호 \(receiveItem.orderNum!)"
        lblOrderDate.text="\(receiveItem.orderDate!)"
        lblOrderDate2.text="\(receiveItem.orderDate!)"
        lblOrderDate3.text="\(receiveItem.orderDate!)"
        lblOrderLoc.text="\(receiveItem.storename!)"
        lblOrderLoc2.text="\(receiveItem.storename!)"
        lblOrderLoc3.text="\(receiveItem.storename!)"
        lblOrderLoc4.text="\(receiveItem.storename!)"
        lblOrderLocDetail.text="\(receiveItem.address!)"
        lblDrinkName.text="\(receiveItem.name!)"
        lblCount.text="총 \(receiveItem.orderCount!)개"
        lblPrice.text=DecimalWon(value: (receiveItem.price! * receiveItem.orderCount!) + (receiveItem.orderPersonalPrice! * receiveItem.orderCount!))
    }
    
    @IBAction func btnRefresh(_ sender: UIButton) {
        updateTime()
    }
    
    
    func receiveItems(_ item:HistoryModel){
        receiveItem=item
    }
    
    func dateChange(){
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale=Locale(identifier: "ko")

        orderDate = dateFormatter.date(from: receiveItem.orderDate!)!
    }
    
    @objc func updateTime(){
        let date=NSDate() // Next Step
        
        nowTime=date as Date
        
        if nowTime >= orderDate{
            lblOrderFin.isHidden=false
            orderPerm.backgroundColor=UIColor.lightGray
            orderReady.backgroundColor=UIColor.brown
        }else{
            lblOrderFin.isHidden=true
            orderPerm.backgroundColor=UIColor.brown
            orderReady.backgroundColor=UIColor.lightGray
        }
    }
    
    func DecimalWon(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))! + " 원"
        
        return result
    }
}
