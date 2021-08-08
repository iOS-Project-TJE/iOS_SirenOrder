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
    var name: String?
    var img: String?
    var price: Int?
    var totalCount: Int?
    
    override init() {
        
    }
    
    // 2021.08.06 조혜지 OrderNumModel에서 사용할 init 추가
    init(orderNum: String) {
        self.orderNum = orderNum
    }
    
    // 2021.08.07 조혜지 DrinkOrderModel에서 사용할 init 추가
    init(orderCount : Int, orderPersonal : String, orderDate : String, cd : String, orderPersonalPrice: Int, name: String, img: String, price: Int){
        self.orderCount = orderCount
        self.orderPersonal = orderPersonal
        self.orderDate = orderDate
        self.cd = cd
        self.orderPersonalPrice = orderPersonalPrice
        self.name = name
        self.img = img
        self.price = price
    }
    
    // 2021.08.07 조혜지 OrderCountModel에서 사용할 init 추가
    init(totalCount: Int) {
        self.totalCount = totalCount
    }
    
}
