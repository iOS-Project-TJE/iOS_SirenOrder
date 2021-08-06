//
//  CartCountUpdateModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import Foundation

// 21.08.05 조혜지 장바구니 수량 업데이트하는 Dao
class CartCountUpdateModel {
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/cartUpdate.jsp"
    
    func uodateItems(_ cartCount: Int, _ cartId: Int) -> Bool {
        var result: Bool = true
        let urlAdd = "?cartCount=\(cartCount)&cartId=\(cartId)"
        urlPath = urlPath + urlAdd
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
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
