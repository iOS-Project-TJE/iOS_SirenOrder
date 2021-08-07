//
//  LocationList.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/04.
//

import Foundation
protocol LocationListProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class LocationList: NSObject{
    var delegate: LocationListProtocol!
    let urlPath = "http://\(macIp):8080/starbucks/jsp/seolin/locationList_select.jsp"
    
    
    func downloadItems(){
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
            print("Data 1")
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
                print(storename)
                locations.add(query)
            }
        }
        print("Data 2")
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
}
