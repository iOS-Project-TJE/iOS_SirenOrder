//
//  FrequentStoreModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/02.
//

import Foundation

// 21.08.02 조혜지 Order 자주 가는 매장 Table View Dao
protocol FrequentStoreModelProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class FrequentStoreModel: NSObject{
    var delegate: FrequentStoreModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/frequentStoreSelect.jsp"
    
    func downloadItems(){
        
        let urlAdd = "?userId=\(userId)"
        urlPath = urlPath + urlAdd
        
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
            jsonResult=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
        
        for i in 0..<jsonResult.count{
            jsonElement = jsonResult[i] as! NSDictionary
            if let storename = jsonElement["storename"] as? String,
               let lat = jsonElement["lat"] as? String,
               let lon = jsonElement["lon"] as? String,
               let address = jsonElement["address"] as? String{
                let query = LocationModel(storename: storename, lat: Double(lat)!, lon: Double(lon)!, address: address)
                locations.add(query)
            }
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
}
