//
//  ShareOrder.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/04.
//

import Foundation

struct ShareOrder {
    
    // 2021.08.04 조혜지 주문하기 버튼 클릭 시 데이터 공유하는 변수 추가
    static var orderCd: String = ""
    static var orderName: String = ""
    static var orderCount: Int = 0
    static var orderPersonal : String = ""
    static var orderPersonalPrice: Int = 0
    static var orderPrice: Int = 0
    static var orderImg: String = ""
    
    // 2021.08.06 조혜지 장바구니에서 주문하기 버튼 클릭 알려주는 상태 변수 및 데이터 공유하는 변수 추가
    static var cartOrder = false
}
