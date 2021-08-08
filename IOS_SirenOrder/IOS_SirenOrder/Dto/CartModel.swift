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
    var cartCheck: String?
 
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
    
    // 2021.08.06 조혜지 CartCheckModel에서 사용할 Dto 추가
    init(cartCheck: String){
        self.cartCheck = cartCheck
    }
    
    // 2021.08.06 조혜지 CartForUpdateSelectModel에서 사용할 Dto 추가
    init(cartId: String, cartCount: Int){
        self.cartId = cartId
        self.cartCount = cartCount
    }
}
