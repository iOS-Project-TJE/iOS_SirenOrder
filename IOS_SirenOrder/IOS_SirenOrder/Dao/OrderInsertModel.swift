//
//  OrderInsertModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/06.
//

import Foundation

// 21.08.02 조혜지 Order 결제하는 Dao
class OrderInsertModel {
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/orderInsert.jsp"
    
    func InsertItems(orderNum: String, orderCount: Int, orderPersonal: String, storeName: String, cd: String, userId: String, cartPersonalPrice: Int) -> Bool {
        var result: Bool = true
        let urlAdd = "?orderNum=\(orderNum)&orderCount=\(orderCount)&orderPersonal=\(orderPersonal)&storeName=\(storeName)&cd=\(cd)&userId=\(userId)&cartPersonalPrice=\(cartPersonalPrice)"
        urlPath = urlPath + urlAdd
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to insert data")
                result = false
            }else{
                print("Data is inserted!")
                result = true
            }
        }
        task.resume()
        return result
    }
    
}
