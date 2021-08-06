//
//  CartDeleteModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import Foundation

// 21.08.05 조혜지 장바구니 선택 삭제하는 Dao
class CartDeleteModel {
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/cartDelete.jsp"
    
    func deleteItems(_ cartId: String) -> Bool {
        var result: Bool = true
        let urlAdd = "?cartId=\(cartId)&userId=\(userId)"
        urlPath = urlPath + urlAdd
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to delete data")
                result = false
            }else{
                print("Data is deleted!")
                result = true
            }
        }
        task.resume()
        return result
    }
    
}
