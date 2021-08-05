//
//  OrderModel.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/31.
//

import Foundation

class OrderModel : NSObject{
    var orderId : String?
    var orderNum : String?
    var orderCount : Int?
    var orderPersonal : String?
    var orderDate : String?
    var storename : String?
    var cd : String?
    var userId : String?
    
    override init() {
        
    }
    
    init(orderId : String, orderNum : String, orderCount : Int, orderPersonal : String, orderDate : String, storename : String, cd : String, userId : String){
        self.orderId=orderId
        self.orderNum=orderNum
        self.orderCount=orderCount
        self.orderPersonal=orderPersonal
        self.orderDate=orderDate
        self.storename=storename
        self.cd=cd
        self.userId=userId
    }
}
