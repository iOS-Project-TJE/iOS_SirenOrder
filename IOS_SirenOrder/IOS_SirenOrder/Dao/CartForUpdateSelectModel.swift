//
//  CartForUpdateSelectModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/06.
//

import Foundation

// 2021.08.05 조혜지 Order Cart View Dao
protocol CartForUpdataeSelectModelProtocol : AnyObject {
    func cartItemDownloaded(items: NSMutableArray)
}

class CartForUpdateSelectModel : NSObject {
    var delegate: CartForUpdataeSelectModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/hj/cartForUpdateSelect.jsp"
    
    func downloadItems(_ cd: String, _ cartPersonal: String, _ cartCount: Int) {
        
        let urlAdd = "?userId=\(userId)&cd=\(cd)&cartPersonal=\(cartPersonal)&cartCount=\(SharePersonalData.drinkCount)"
        urlPath = urlPath + urlAdd
        print(urlPath)
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to download data")
            }else{
                print("Data is downloaded 되는거냐??????")
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
               let cartCount = jsonElement["cartCount"] as? String{
                
                let query = CartModel(cartId: cartId, cartCount: Int(cartCount)!)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.cartItemDownloaded(items: locations)
    })
    }
}
