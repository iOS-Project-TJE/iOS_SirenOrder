//
//  StoreSearchModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/03.
//

import Foundation

// 21.08.03 조혜지 Order 매장 검색 결과 정보 불러오는 Dao
protocol StoreSearchModelProtocol : AnyObject {
    func itemDownloaded(items: NSMutableArray)
}

class StoreSearchModel : NSObject {
    var delegate: StoreSearchModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/"
    
    func downloadItems(searchText: String) {
        let urlAdd = "storeSearchSelect.jsp?searchText=\(searchText)"
        urlPath = urlPath + urlAdd
        print(urlPath)
        
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
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
            if let storename = jsonElement["storename"] as? String,
               let lat = jsonElement["lat"] as? String,
               let long = jsonElement["long"] as? String,
               let address = jsonElement["address"] as? String{
                let query = LocationModel(storename: storename, lat: Double(lat)!, long: Double(long)!, address: address)
                locations.add(query)
            }
        
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
    })
    }
}
