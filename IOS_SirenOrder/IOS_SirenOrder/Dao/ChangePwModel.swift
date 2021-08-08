//
//  ChangePwModel.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/08.
//

import Foundation

class ChangePwModel{
    
    var urlPath = "http://\(macIp):8080/starbucks/jsp/he/changePwUpdate.jsp"
    
    func changePwItems(password: String, id: String) -> Bool { //data를 달고 넘어와서 DB연결해야함
        
        var result: Bool = true
        let urlAdd = "?password=\(password)&id=\(id)" // 띄어쓰기하면 안됨!
        urlPath = urlPath + urlAdd // 진짜 url
        print("changePw urlPath: \(urlPath)")
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        

        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession.init(configuration: URLSessionConfiguration.default)
        
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            
            if error != nil{
                print("Failed to changePw data")
                result = false
            }else{
                print("ChangePw data is succeed")
                result = true
                
            }
            
        }
        //task 실행
        task.resume()
        return result
    }

}//-----
