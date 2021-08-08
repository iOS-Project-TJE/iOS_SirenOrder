//
//  UserInfoModel.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/08.
//

import Foundation

protocol UserInfoModelProtocol{
   
    func itemDownloaded(items: NSArray)
}

class UserInfoModel{
    
    var delegate: UserInfoModelProtocol!
    let urlPath = "http://\(macIp):8080/starbucks/jsp/he/userInfoSelect.jsp"
    
    func downloadItems(){
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession.init(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloaded")
                self.parseJSON(data!)
            }
            
        }
        //task 실행
        task.resume()
    }
    
  
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()//어레이
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray //as는 casting
        
        }catch let error as NSError{
            print(error)
        }
        
        //하나씩 뽑아오기
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            if let userId = jsonElement["userId"] as? String,
               let userPw = jsonElement["userPw"] as? String,
               let userNickname = jsonElement["userNickname"] as? String,
               let userEmail = jsonElement["userEmail"] as? String {
                let query = LoginUserInfoModel(userId: userId, userPw: userPw, userNickname: userNickname, userEmail: userEmail)
                
                
                locations.add(query)
                
            }
    
        }
        
        DispatchQueue.main.async(execute: {() -> Void in
            //itemDownloaded에게 파싱한 내용 주기
            self.delegate.itemDownloaded(items: locations)
        })
        
    }
}
