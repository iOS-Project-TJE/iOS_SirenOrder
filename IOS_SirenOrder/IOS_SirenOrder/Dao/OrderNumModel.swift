//
//  OrderNumModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/06.
//

import Foundation

// 21.08.05 조혜지 max orderNumber 알기 위한 Dao
protocol OrderNumModelProtocol : AnyObject {
    func orderNumDownloaded(items: NSMutableArray)
}

class OrderNumModel : NSObject {
    var delegate: OrderNumModelProtocol!
    let urlPath = "http://\(macIp):8080/starbucks/jsp/hj/orderNumSelect.jsp"
    
    func downloadItems() {
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
        
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            if let orderNum = jsonElement["orderNum"] as? String{

                let query = OrderModel(orderNum: orderNum)
                locations.add(query)

                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.orderNumDownloaded(items: locations)
    })
    }
}
