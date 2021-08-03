//
//  DrinkModel.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/31.
//

import Foundation

class DrinkModel : NSObject{
    var cd : String?
    var name : String?
    var img : String?
    var allergie : String?
    var content : String?
    var category : String?
    var volume : String?
    var kcal : String?
    var protein : String?
    var fat : String?
    var sodium : String?
    var sugars : String?
    var caffeine : String?
    var cholesterol : String?
    var carbo : String?
    var type : Int?
    var price : Int?
    
 
    override init() {
        
    }
    
    init(cd : String, name : String, img : String, allergie : String, content : String, category : String, volume : String, kcal : String, protein : String, fat : String, sodium : String, sugars : String, caffeine : String, cholesterol : String, carbo : String, type : Int, price : Int){
        self.cd=cd
        self.name=name
        self.img=img
        self.allergie=allergie
        self.content=content
        self.category=category
        self.volume=volume
        self.kcal=kcal
        self.protein=protein
        self.fat=fat
        self.sodium=sodium
        self.sugars=sugars
        self.caffeine=caffeine
        self.cholesterol=cholesterol
        self.carbo=carbo
        self.type=type
        self.price=price
    }
    
    // 2021.08.01 조혜지 categoryDetailModel에서 사용할 init 추가
    init(cd: String, name : String, img : String, price : Int) {
        self.cd = cd
        self.name = name
        self.img = img
        self.price = price
    }
    
    // 2021.08.02 조혜지 DrinkInfoModel에서 사용할 init 추가
    init(name : String, price : Int, type: Int) {
        self.name = name
        self.price = price
        self.type = type
    }
}
