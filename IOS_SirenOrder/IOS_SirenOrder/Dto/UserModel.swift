//
//  UserModel.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/31.
//

import Foundation

class UserModel : NSObject{
    var userId : String?
    var userPw : String?
    var userNickname : String?
    var userEmail : String?
    var userSigndate : String?
    var userDropdate : String?
    var giftPrice: Int?
    
    override init() {
        
    }
    
    init(userId : String, userPw : String, userNickname : String, userEmail : String, userSigndate : String, userDropdate : String){
        self.userId = userId
        self.userPw = userPw
        self.userNickname = userNickname
        self.userEmail = userEmail
        self.userSigndate = userSigndate
        self.userDropdate = userDropdate
    }
    
    // 2021.08.06 조혜지 GiftPriceModel에서 사용할 init 추가
    init(giftPrice: Int) {
        self.giftPrice = giftPrice
    }
    
    // 2021.08.06 조혜지 GiftPriceUpdateModel에서 사용할 Dto 추가
    init(userId: String, giftPrice: Int){
        self.userId = userId
        self.giftPrice = giftPrice
    }
}
