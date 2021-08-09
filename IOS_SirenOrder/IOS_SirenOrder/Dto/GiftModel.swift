//
//  GiftModel.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/05.
//

import Foundation
class GiftModel: NSObject {
    //gift
    var giftId : String?
    var giftSender : String?
    var giftReceiver : String?
    var card_cd : String?
    var price : String?
    var payDate : String?
    
    //card
    var cd : String?
    var name : String?
    var img : String?
    var launch : String?
    
    override init() {
    
    }
    
    init(giftId : String, giftSender : String, giftReceiver : String, card_cd : String, price : String, payDate : String, cd : String, name : String, img : String) {
        self.giftId=giftId
        self.giftSender=giftSender
        self.giftReceiver=giftReceiver
        self.card_cd=card_cd
        self.price=price
        self.payDate=payDate
        
        self.cd=cd
        self.name=name
        self.img=img
    }
}
