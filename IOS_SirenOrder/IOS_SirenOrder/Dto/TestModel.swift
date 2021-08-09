//
//  TestModel.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/09.
//

import Foundation
class TestModel: NSObject {
    var userId : String?

    
    override init() {
    
    }
    
    init(userId : String) {
        self.userId=userId
    }
}
