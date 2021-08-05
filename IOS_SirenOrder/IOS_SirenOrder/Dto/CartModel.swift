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
 
    override init() {
        
    }
    
    init(cartId: String, cartCount: Int, cartPersonal: String, cd: String, cartPersonalPrice: Int){
        self.cartId = cartId
        self.cartCount = cartCount
        self.cartPersonal = cartPersonal
        self.cd = cd
        self.cartPersonalPrice = cartPersonalPrice
    }
    
}
