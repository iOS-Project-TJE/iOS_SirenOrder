//
//  VerifyDuplicatedIdModel.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/08.
//

import Foundation

protocol VerifyDuplicatedIdProtocol{
   
    func itemDownloaded(items: String)
}


class VerifyDuplicatedIdModel{
    
    var delegate: VerifyDuplicatedIdProtocol!
    
    func downloadItems(subUrl: String){
        
        var urlPath = "http://\(macIp):8080/starbucks/jsp/he/verifyDuplicatedId.jsp?id=\(subUrl)"
        print(urlPath)
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession.init(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download verifyDuplicatedId data")
            }else{
                print("VerifyDuplicatedId Data is downloaded")
                self.parseJSON(data!)
            }
            
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var json = ["":""]
        do{
            json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String:String]
                   }catch let  error as NSError{
                       print(error)
                   }
                   let result = json["result"]!
        
        DispatchQueue.main.async(execute: {() -> Void in
            // delegate = JsonModelProtocol
            //itemDownloaded에게 파싱한 내용 주기
            
            self.delegate.itemDownloaded(items: result)
            print("locations : \(result)")
        })
        
    }
}
