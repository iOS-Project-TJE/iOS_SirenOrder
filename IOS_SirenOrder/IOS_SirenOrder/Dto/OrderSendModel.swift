//
//  OrderSendModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import Foundation

// 2021.08.05 조혜지 OrderSend (결제하기로 보내줄 때 데이터 보내기 위한 Model) Dto 추가
class OrderSendModel : NSObject{
    var cd : String?
    var count : Int?
    var personalContent: String?
    var personalPrice: Int?
 
    override init() {
        
    }
    
    init(cd: String, count: Int, personalContent: String, personalPrice: Int){
        self.cd = cd
        self.count = count
        self.personalContent = personalContent
        self.personalPrice = personalPrice
    }
    
}
