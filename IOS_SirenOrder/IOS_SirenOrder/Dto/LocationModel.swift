//
//  LocationModel.swift
//  IOS_SirenOrder
//
//  Created by Biso on 2021/08/04.
//

import Foundation
class LocationModel: NSObject {
    var storename : String?
    var lat : Double?
    var lon : Double?
    var address : String?
    
    override init() {
    
    }
    
    init(storename : String, lat : Double, lon : Double, address : String) {
        self.storename=storename
        self.lat=lat
        self.lon=lon
        self.address=address
    }
}
