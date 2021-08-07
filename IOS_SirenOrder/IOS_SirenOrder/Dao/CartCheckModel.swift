//
//  CartCheckModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/06.
//

import Foundation

// 21.08.05 조혜지 장바구니에 이미 상품이 있는지 여부 알기 위한 Dao
protocol CartCheckModelProtocol : AnyObject {
    func priceDownloaded(items: NSMutableArray)
}

class CartCheckModel : NSObject {
    var delegate: CartCheckModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/"
    
    func downloadItems(_ cd: String, _ cartPersonal: String, _ cartCount: Int) {
        let urlAdd = "cartCheck.jsp?userId=\(userId)&cd=\(cd)&cartPersonal=\(cartPersonal)&cartCount=\(SharePersonalData.drinkCount)"
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
                
        for i in 0..<jsonResult.count {
            jsonElement = jsonResult[i] as! NSDictionary
            if let cartCheck = jsonElement["cartCheck"] as? String{

                let query = CartModel(cartCheck: cartCheck)
                locations.add(query)

                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.priceDownloaded(items: locations)
    })
    }
}
