//
//  HistoryList.swift
//  IOS_SirenOrder
//
//  Created by 박성준 on 2021/07/31.
//

import Foundation

protocol HistoryModelProtocol : AnyObject {
    func itemDownloaded(items: NSMutableArray)
}

class HistoryListModel: NSObject{
    var delegate: HistoryModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/sj/"
    
    func downloadHistoryItems(){
        var urlAdd=""
        urlAdd="HistoryList.jsp?userId=\(userId)"
        
        urlPath += urlAdd
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data,response,error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloaded")
                self.parseJSON(data!)
            }
            self.parseJSON(data!)
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
               let orderCount = jsonElement["orderCount"] as? String,
               let orderPersonal = jsonElement["orderPersonal"] as? String,
               let orderDate = jsonElement["orderDate"] as? String,
               let storename = jsonElement["storename"] as? String,
               let cd = jsonElement["cd"] as? String,
               let price = jsonElement["price"] as? String,
               let img = jsonElement["img"] as? String,
               let name = jsonElement["name"] as? String{
                let query = OrderModel(orderId: orderId, orderNum: orderNum, orderCount: Int(orderCount)!, orderPersonal: orderPersonal, orderDate: orderDate, storename: storename, cd: cd, price: Int(price)!, img: img, name: name)
                locations.add(query)
            }
        }
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
}
