//
//  MyMenuInsertModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import Foundation

// 21.08.02 조혜지 Order 나만의 메뉴 추가하는 Dao
class MyMenuInsertModel {
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/myMenuInsert.jsp"
    
    func InsertItems(personalContent: String, cd: String, userId: String) -> Bool {
        var result: Bool = true
        let urlAdd = "?personalContent=\(personalContent)&cd=\(cd)&userId=\(userId)"
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
