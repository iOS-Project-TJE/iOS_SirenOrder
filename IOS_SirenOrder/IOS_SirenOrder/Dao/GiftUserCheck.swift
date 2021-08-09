//
//  GiftUserCheck.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/08.
//

import Foundation
protocol GiftUserCheckProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class GiftUserCheck {
    var catcher = false
    var delegate: GiftUserCheckProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/seolin/gift_user_check.jsp"
    
    func selectItems(giftReceiver: String, receiverAddress: String) -> Bool{

        let urlAdd = "?&giftReceiver=\(giftReceiver)&receiverAddress=\(receiverAddress)"
        urlPath = urlPath + urlAdd
        
        print(urlPath)
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil {
                print("Failed to Insert Gift Data")
            }else {
                print("Gift Data is select")
                self.catcher = self.parseJSON(data!)
            }
        }
        task.resume()
        return catcher
        
    }
    func parseJSON(_ data: Data) -> Bool {
        var jsonResult = NSArray()
        var result:Bool = true
        do{
            print("Data 1")
            jsonResult=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! NSArray
        }catch let error as NSError{
            print(error)
        }
        
        var jsonElement = NSDictionary()
        
        if jsonResult.count != 0 {
            jsonElement = jsonResult[0] as! NSDictionary
            if let userId = jsonElement["userId"] as? String{
                if userId != "" {
                    result = true
                }else {
                    result = false
                }
                print(userId, result)
            }
        }
        return result
    }
}
