//
//  SearchDetailModel.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/08.
//

import Foundation

protocol SearchDetailModelProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class SearchDetailModel : NSObject {
    var delegate: SearchDetailModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/dw/"
    
    func downloadItems(name: String) {
        let urlAdd = "searchDetail.jsp?name=\(name)"
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
            if let cd = jsonElement["cd"] as? String,
               let name = jsonElement["name"] as? String,
               let img = jsonElement["img"] as? String,
               let price = jsonElement["price"] as? String{
                
                let query = DrinkModel(cd: cd, name: name, img: img, price: Int(price)!)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
    })
    }
}
