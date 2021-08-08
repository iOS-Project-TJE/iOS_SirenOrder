//
//  SearchSQLiteModel.swift
//  IOS_SirenOrder
//
//  Created by RayAri on 2021/08/09.
//

import Foundation

class SearchSQLiteModel {
    var num:Int?
    var searchText:String?
    
    init(num: Int, searchText: String){
        self.num = num
        self.searchText = searchText
    }
}
