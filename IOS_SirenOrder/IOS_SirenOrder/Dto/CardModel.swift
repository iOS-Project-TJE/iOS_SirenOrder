//
//  CardModel.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import Foundation
class CardModel: NSObject {
    var cd : String?
    var name : String?
    var img : String?
    var launch : String?
    
    override init() {
    
    }
    
    init(cd : String, name : String, img : String, launch : String) {
        self.cd=cd
        self.name=name
        self.img=img
        self.launch=launch
    }
}
