//
//  GiftSendModel.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/05.
//

import Foundation
class GiftSend{
    var urlPath = "http://\(macIp):8080/starbucks/jsp/seolin/gift_insert.jsp"
    
    func insertItems(giftSender: String, giftReceiver: String, card_cd: String, price: String) -> Bool {
        var result: Bool = true
        let urlAdd = "?giftSender=\(giftSender)&giftReceiver=\(giftReceiver)&card_cd=\(card_cd)&price=\(price)"
        urlPath = urlPath + urlAdd
        
        print(urlPath)
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to Insert Gift Data")
                result = false
            }else {
                print("Gift Data is Insert")
                result = true
            }
        }
        task.resume()
        return result
    }
    
}
