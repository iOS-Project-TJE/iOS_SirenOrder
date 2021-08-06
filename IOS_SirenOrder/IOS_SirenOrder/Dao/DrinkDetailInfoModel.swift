//
//  DrinkDetailInfoModel.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/07.
//

import Foundation

protocol DrinkDetailInfoModelProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class DrinkDetailInfoModel : NSObject {
    var delegate: DrinkDetailInfoModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/dw/"
    
    func downloadItems(cd: String) {
        let urlAdd = "drinkDetailInfo.jsp?cd=\(cd)"
        urlPath = urlPath + urlAdd
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            print("Data is \(String(describing: data))")
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
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            if let cd = jsonElement["cd"] as? String,
               let img = jsonElement["img"] as? String,
               let name = jsonElement["name"] as? String,
               let content = jsonElement["content"] as? String,
               let price = jsonElement["price"] as? String,
               let type = jsonElement["type"] as? String,
               let allergie = jsonElement["allergie"] as? String{
                
                let query = DrinkModel(cd: cd, img: img, name: name, content: content, price: Int(price)!, type: Int(type)!, allergie: allergie)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
    })
    }
}
