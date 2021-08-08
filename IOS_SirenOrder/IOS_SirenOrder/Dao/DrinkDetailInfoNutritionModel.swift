//
//  DrinkDetailInfoNutritionModel.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/07.
//

import Foundation

protocol DrinkDetailInfoNutritionModelProtocol : AnyObject {
    func itemDownloaded(items: NSArray)
}

class DrinkDetailInfoNutritionModel : NSObject {
    var delegate: DrinkDetailInfoNutritionModelProtocol!
    var urlPath = "http://\(macIp):8080/starbucks/jsp/dw/"
    
    func downloadItems(cd: String) {
        let urlAdd = "drinkDetailInfoNutrition.jsp?cd=\(cd)"
        urlPath = urlPath + urlAdd
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            print("Data is \(String(describing: data))")
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
            if let volume = jsonElement["volume"] as? String,
               let kcal = jsonElement["kcal"] as? String,
               let protein = jsonElement["protein"] as? String,
               let fat = jsonElement["fat"] as? String,
               let sodium = jsonElement["sodium"] as? String,
               let sugars = jsonElement["sugars"] as? String,
               let caffeine = jsonElement["caffeine"] as? String,
               let cholesterol = jsonElement["cholesterol"] as? String,
               let carbo = jsonElement["carbo"] as? String{
                
                let query = DrinkModel(volume: volume, kcal: kcal, protein: protein, fat: fat, sodium: sodium, sugars: sugars, caffeine: caffeine, cholesterol: cholesterol, carbo: carbo)
                locations.add(query)
                
            }
        }

        DispatchQueue.main.async(execute: {() -> Void in
            self.delegate.itemDownloaded(items: locations)
    })
    }
}
