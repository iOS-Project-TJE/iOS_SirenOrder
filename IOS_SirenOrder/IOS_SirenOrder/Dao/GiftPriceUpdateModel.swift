//
//  GiftPriceUpdateModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/07.
//

import Foundation

// 21.08.05 조혜지 기프트 카드 잔액 업데이트하는 Dao
class GiftPriceUpdateModel {
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/giftPriceUpdate.jsp"

    func updateItems(_ giftPrice: Int) -> Bool {
        var result: Bool = true
        let urlAdd = "?userId=\(userId)&giftPrice=\(giftPrice)"
        urlPath = urlPath + urlAdd
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        print(urlPath)
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to delete data")
                result = false
            }else{
                print("Data is updated!")
                result = true
            }
        }
        task.resume()
        return result
    }
    
}
