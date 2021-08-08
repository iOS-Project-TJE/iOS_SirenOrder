//
//  LoginUserInfoModel.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/08.
//

import Foundation

class LoginUserInfoModel: NSObject{
        
    var userId: String?
    var userPw: String?
    var userNickname: String?
    var userEmail: String?
    
    //Empty constructor  //*** 잊지말자!
    override init() {
        
    }
    
    init(userId: String, userPw: String, userNickname: String, userEmail: String) { //DB
        self.userId = userId
        self.userPw = userPw
        self.userNickname = userNickname
        self.userEmail = userEmail
        
    }
    
}//class
