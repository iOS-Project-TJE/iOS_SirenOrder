//
//  PaidCardList.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/05.
//

import Foundation

protocol PaidCardListProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class PaidCardList: NSObject{
    var delegate: PaidCardListProtocol!
    let urlPath = "http://\(macIp):8080/starbucks/jsp/seolin/paidCardList_select_where.jsp"
    
    
    func downloadItems(_ userId : String?){
        let url: URL = URL(string: urlPath + "?&userId=" + userId!)!
        print(url)
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
            if let giftId = jsonElement["giftId"] as? String,
               let giftSender = jsonElement["giftSender"] as? String,
               let giftReceiver = jsonElement["giftReceiver"] as? String,
              let card_cd = jsonElement["card_cd"] as? String,
              let price = jsonElement["price"] as? String,
             let payDate = jsonElement["payDate"] as? String,
                let cd = jsonElement["card_cd"] as? String,
               let name = jsonElement["name"] as? String,
               let img = jsonElement["img"] as? String{
                print(giftReceiver)
                let query = GiftModel(giftId: giftId, giftSender: giftSender, giftReceiver: giftReceiver, card_cd: card_cd, price: price, payDate: payDate, cd: cd, name: name, img: img)
                
                locations.add(query)
            }
        }
        print("Data 2")
        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
        })
    }
}
