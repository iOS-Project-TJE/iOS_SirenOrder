//
//  CartPriceModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/05.
//

import Foundation

// 21.08.05 조혜지 장바구니 총 가격 정보 불러오는 Dao
protocol CartPriceModelProtocol : AnyObject {
    func priceDownloaded(items: NSMutableArray)
}

class CartPriceModel : NSObject {
    var delegate: CartPriceModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/"
    
    func downloadItems() {
        let urlAdd = "cartPriceSelect.jsp?userId=\(userId)"
        urlPath = urlPath + urlAdd
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
        
        print(jsonResult.count)
        
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            if let totalPrice = jsonElement["totalPrice"] as? String{
                
                let query = CartModel(totalPrice: Int(totalPrice)!)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.priceDownloaded(items: locations)
    })
    }
}
