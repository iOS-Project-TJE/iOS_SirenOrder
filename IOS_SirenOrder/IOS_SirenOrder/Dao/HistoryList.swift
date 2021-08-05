//
//  HistoryList.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/04.
//

import Foundation

protocol HistoryListProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class HistoryList: NSObject{
    var delegate: HistoryListProtocol!
    let urlPath = "http://localhost:8080/starbucks/HistoryList.jsp"
    
    func downloadItems(){
        let userId = UserDefaults.standard.string(forKey: "userId")
        let url: URL = URL(string: urlPath+"?userId=\((userId)!)")!
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
            if let orderId = jsonElement["orderId"] as? String,
               let orderNum = jsonElement["orderNum"] as? String,
               let orderCount = jsonElement["orderCount"] as? Int,
               let orderPersonal = jsonElement["orderPersonal"] as? String,
               let orderDate = jsonElement["orderDate"] as? String,
               let storename = jsonElement["storename"] as? String,
               let cd = jsonElement["cd"] as? String,
               let userId = jsonElement["userId"] as? String{
                let query = OrderModel(orderId: orderId, orderNum: orderNum, orderCount: orderCount, orderPersonal: orderPersonal, orderDate: orderDate, storename: storename, cd: cd, userId: userId)
                locations.add(query)
            }
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
}
