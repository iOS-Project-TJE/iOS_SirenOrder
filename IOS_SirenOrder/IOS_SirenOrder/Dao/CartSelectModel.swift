//
//  CartSelectModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import Foundation

// 2021.08.05 조혜지 Order Cart View Dao
protocol CartSelectModelProtocol : AnyObject {
    func cartItemDownloaded(items: NSArray)
}

class CartSelectModel : NSObject {
    var delegate: CartSelectModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/cartSelect.jsp"
    
    func downloadItems() {
        
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
            jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        let locations = NSMutableArray()
                
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            if let cartId = jsonElement["cartId"] as? String,
               let cartCount = jsonElement["cartCount"] as? String,
               let cartPersonal = jsonElement["cartPersonal"] as? String,
               let cd = jsonElement["cd"] as? String,
               let cartPersonalPrice = jsonElement["cartPersonalPrice"] as? String,
               let name = jsonElement["name"] as? String,
               let img = jsonElement["img"] as? String,
               let price = jsonElement["price"] as? String{
                
                let query = CartModel(cartId: cartId, cartCount: Int(cartCount)!, cartPersonal: cartPersonal, cd: cd, cartPersonalPrice: Int(cartPersonalPrice)!, name: name, img: img, price: Int(price)!)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.cartItemDownloaded(items: locations)
    })
    }
}
