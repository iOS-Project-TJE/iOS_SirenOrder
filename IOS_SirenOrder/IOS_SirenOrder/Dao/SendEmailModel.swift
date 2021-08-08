//
//  SendEmailModel.swift
//  IOS_SirenOrder
//
//  Created by HyoEun Kwon on 2021/08/08.
//

import Foundation

class SendEmailModel{
     
    func sendEmail(email: String, password: String) -> Bool{
    
        var result : Bool = true
        var urlPath = "http://\(macIp):8080/starbucks/jsp/he/SendEmail.jsp"
        let urlAdd = "?email=\(email)&password=\(password)"
        urlPath += urlAdd
        print("Send Email_func: \(urlPath)")
        
        // 한글 url encoding
        urlPath = urlPath.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let url: URL = URL(string: urlPath)!
        let defaultSession = URLSession(configuration: URLSessionConfiguration.default)
        let task = defaultSession.dataTask(with: url){(data, response, error) in
            if error != nil{
                print("Failed to send email")
                result = false
            }else{
                print("Email is sended")
                result = true
            }
        }
        task.resume()
        return result
        
    }

}
