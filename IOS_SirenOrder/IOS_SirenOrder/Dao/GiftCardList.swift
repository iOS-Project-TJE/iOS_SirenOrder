//
//  GiftCardList.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/02.
//

import Foundation

protocol GiftCardListProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class GiftCardList: NSObject{
    var delegate: GiftCardListProtocol!
    let urlPath = "http://localhost:8080/starbucks/giftCardList_select.jsp"
    
    
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
            if let cd = jsonElement["cd"] as? String,
               let name = jsonElement["name"] as? String,
               let img = jsonElement["img"] as? String,
               let launch = jsonElement["launch"] as? String{
                let query = CardModel(cd: cd, name: name, img: img, launch: launch)
                locations.add(query)
            }
        }
        print("Data 2")
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
}
