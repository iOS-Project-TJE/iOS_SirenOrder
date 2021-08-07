//
//  ReceiptDetailViewController.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/08/04.
//

import UIKit

class ReceiptDetailViewController: UIViewController {
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblDetailLocation: UILabel!
    @IBOutlet weak var lblOrderDate: UILabel!
    @IBOutlet weak var lblNickname: UILabel!
    @IBOutlet weak var lblOrderDrink: UILabel!
    @IBOutlet weak var lblDrinkPrice: UILabel!
    @IBOutlet weak var lblOrderPersonalPrice: UILabel!
    @IBOutlet weak var lblDrinkPriceSum: UILabel!
    @IBOutlet weak var lblOrderPersonal: UILabel!
    @IBOutlet weak var lblOrderSum: UILabel!
    @IBOutlet weak var lblOrderSum2: UILabel!
    @IBOutlet weak var lblOrderNum: UILabel!
    @IBOutlet weak var lblDrinkCount: UILabel!
    @IBOutlet weak var lblChangeDate: UILabel!
    
    
    var receiveItem:ReceiptModel = ReceiptModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dateFormatter=DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd  HH:mm:ss"
        dateFormatter.locale=Locale(identifier: "ko")

        let orderDate = dateFormatter.date(from: receiveItem.orderDate!)!
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if receiveItem.orderPersonal == "null"{
            lblOrderPersonal.text = ""
        }else{
            let firstIndex = receiveItem.orderPersonal!.index(receiveItem.orderPersonal!.startIndex, offsetBy: 0)
            let lastIndex = receiveItem.orderPersonal!.index(receiveItem.orderPersonal!.startIndex, offsetBy: receiveItem.orderPersonal!.count-2)
            lblOrderPersonal.text = String(receiveItem.orderPersonal![firstIndex..<lastIndex])
        }
        
        if receiveItem.orderPersonalPrice! * receiveItem.orderCount! == 0{
            lblOrderPersonalPrice.text = ""
        }
        else{
            lblOrderPersonalPrice.text = Decimal(value: receiveItem.orderPersonalPrice! * receiveItem.orderCount!)
        }

        lblLocation.text = receiveItem.storename!
        lblDetailLocation.text = receiveItem.address!
        lblOrderDate.text = receiveItem.orderDate!
        lblNickname.text = "\(receiveItem.userNickname!) (\(receiveItem.orderNum!))"
        lblOrderDrink.text = receiveItem.name!
        lblDrinkPrice.text = Decimal(value: receiveItem.price!)
        lblDrinkCount.text = "\(receiveItem.orderCount!)"
        lblDrinkPriceSum.text = Decimal(value: receiveItem.orderCount! * receiveItem.price!)
        lblOrderSum.text = Decimal(value: (receiveItem.orderCount! * receiveItem.price!) + (receiveItem.orderCount! * receiveItem.orderPersonalPrice!))
        lblOrderSum2.text = "\(lblOrderSum.text!) 원"
        lblOrderNum.text = receiveItem.orderId!
        lblChangeDate.text = "(변경 가능 기간 : ~ \(dateFormatter.string(from: Calendar.current.date(byAdding: DateComponents(day: 14), to: orderDate)!)))"
    }
    
    func receiveItems(_ item:ReceiptModel){
        receiveItem=item
    }
    
    
    func Decimal(value: Int) -> String{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: NSNumber(value: value))!
        
        return result
    }

}
