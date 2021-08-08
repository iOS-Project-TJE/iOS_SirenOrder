//
//  InsertSignInfo.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/08.
//

import Foundation

class InsertSignInfoModel{
    
    var urlPath = "http://\(macIp):8080/starbucks/jsp/he/userIdPwNickInsert.jsp" // + urlAdd ( ?와 & 로 쭉쭉 이어갈 거임)
    
    func insertItems(userId: String, userPw: String, userNickname: String, userEmail: String) -> Bool {
       
        var result: Bool = true
        let urlAdd = "?userId=\(userId)&userPw=\(userPw)&userNickname=\(userNickname)&userEmail=\(userEmail)"
        urlPath = urlPath + urlAdd // 진짜 url
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        

        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession.init(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to insert idPw data")
                result = false
            }else{
                print("idPw Data is Inserted")
                result = true
                
            }
            
        }
        // resume 위에 url, defaultSission, task 는 선언임
        //task 실행
        task.resume()
        return result
    }

}//-----
