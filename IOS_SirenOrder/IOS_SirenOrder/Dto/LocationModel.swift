//
//  LocationModel.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/07/31.
//

import Foundation

// 2021.07.31 조혜지 Location Dto 추가
class LocationModel : NSObject{
    var storename : String?
    var lat : Double?
    var lon : Double?
    var address : String?
 
    override init() {
        
    }
    
    init(storename: String, lat: Double, lon: Double, address: String){
        self.storename = storename
        self.lat = lat
        self.lon = lon
        self.address = address
    }

}
