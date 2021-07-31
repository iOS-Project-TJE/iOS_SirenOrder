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
}
