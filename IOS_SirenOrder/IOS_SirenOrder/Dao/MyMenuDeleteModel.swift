//
//  MyMenuDeleteModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import Foundation

// 21.08.02 조혜지 Order 나만의 메뉴 삭제하는 Dao
class MyMenuDeleteModel {
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/myMenuDelete.jsp"
    
    func DeleteItems(personalId: String) -> Bool {
        var result: Bool = true
        let urlAdd = "?personalId=\(personalId)"
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
                print("Data is deleted!")
                result = true
            }
        }
        task.resume()
        return result
    }
    
}
