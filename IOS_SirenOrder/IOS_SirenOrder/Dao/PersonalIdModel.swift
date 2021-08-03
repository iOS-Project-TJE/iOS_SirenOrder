//
//  PersonalIdModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import Foundation

// 21.08.02 조혜지 Order myMenu Insert 후, PersonalId 정보 불러오는 Dao
protocol PersonalIdModelProtocol : AnyObject {
    func itemDownloaded(items: NSMutableArray)
}

class PersonalIdModel : NSObject {
    var delegate: PersonalIdModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/"
    
    func downloadItems() {
        let urlAdd = "personalIdSelect.jsp?userId=\(userId)"
        urlPath = urlPath + urlAdd
        print(urlPath)
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloaded")
                self.parseJSON(data!)
            }
        }
        task.resume()
    }
    
    func parseJSON(_ data: Data){
        var jsonResult = NSArray()
        do{
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        print(jsonResult.count)
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            if let personalId = jsonElement["personalId"] as? String{
                
                let query = PersonalModel(personalId: personalId)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
    })
    }
}
