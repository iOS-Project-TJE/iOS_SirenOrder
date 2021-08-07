//
//  OrderSelectModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/07.
//

import Foundation

// 2021.08.05 조혜지 Order 최종 결제 확인 View Dao
protocol OrderSelectModelProtocol : AnyObject {
    func orderDownloaded(items: NSArray)
}

class OrderSelectModel : NSObject {
    var delegate: OrderSelectModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/orderSelect.jsp"
    
    func downloadItems(_ orderNum: String) {
        
        let urlAdd = "?orderNum=\(orderNum)"
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
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
                
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            if let orderCount = jsonElement["orderCount"] as? String,
               let orderPersonal = jsonElement["orderPersonal"] as? String,
               let orderDate = jsonElement["orderDate"] as? String,
               let cd = jsonElement["cd"] as? String,
               let orderPersonalPrice = jsonElement["orderPersonalPrice"] as? String,
               let name = jsonElement["name"] as? String,
               let img = jsonElement["img"] as? String,
               let price = jsonElement["price"] as? String{
                
                let query = OrderModel(orderCount: Int(orderCount)!, orderPersonal: orderPersonal, orderDate: orderDate, cd: cd, orderPersonalPrice: Int(orderPersonalPrice)!, name: name, img: img, price: Int(price)!)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.orderDownloaded(items: locations)
    })
    }
}
