//
//  CartModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import Foundation

// 2021.08.05 조혜지 Cart Dto 추가
class CartModel : NSObject{
    var cartId : String?
    var cartCount : Int?
    var cartPersonal: String?
    var cd : String?
    var cartPersonalPrice: Int?
    var name: String?
    var img: String?
    var price: Int?
    var totalPrice: Int?
 
    override init() {
        
    }
    
    init(cartId: String, cartCount: Int, cartPersonal: String, cd: String, cartPersonalPrice: Int, name: String, img: String, price: Int){
        self.cartId = cartId
        self.cartCount = cartCount
        self.cartPersonal = cartPersonal
        self.cd = cd
        self.cartPersonalPrice = cartPersonalPrice
        self.name = name
        self.img = img
        self.price = price
    }
    
    init(totalPrice: Int){
        self.totalPrice = totalPrice
    }
}
