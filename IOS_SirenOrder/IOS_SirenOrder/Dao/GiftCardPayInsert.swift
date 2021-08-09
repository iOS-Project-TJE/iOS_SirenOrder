//
//  GiftCardPayInsert.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/09.
//

import Foundation
class GiftCardPayInsert{
    var urlPath = "http://\(macIp):8080/starbucks/jsp/seolin/user_gift_pay_update.jsp"
    
    func insertItems(userId: String, giftPrice: String) {
//        var result: Bool = true
        let urlAdd = "?giftPrice=\(giftPrice)&userId=\(userId)"
        urlPath = urlPath + urlAdd
        
        print(urlPath)
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to Insert Gift Pay Data")
//                result = false
            }else {
                print("Gift Pay Data is Insert")
//                result = true
            }
        }
        task.resume()
//        return result
    }
    
}
