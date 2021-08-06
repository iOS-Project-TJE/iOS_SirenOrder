//
//  OrderModel.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/31.
//

import Foundation

class OrderModel : NSObject{
    var orderNum : String?
    var orderCount : Int?
    var orderPersonal : String?
    var orderDate : String?
    var storename : String?
    var cd : String?
    var userId : String?
    var orderPersonalPrice : Int?
    
    
    override init() {
        
    }
    
    // 2021.08.05 조혜지 DrinkOrderModel에서 사용할 init 추가
    init(orderId : String, orderNum : String, orderCount : Int, orderPersonal : String, orderDate : String, storename : String, cd : String, userId : String, orderPersonalPrice: Int){
        self.orderNum = orderNum
        self.orderCount = orderCount
        self.orderPersonal = orderPersonal
        self.orderDate = orderDate
        self.storename = storename
        self.cd = cd
        self.userId = userId
        self.orderPersonalPrice = orderPersonalPrice
    }

}
