//
//  SharePersonal.swift
//  IOS_SirenOrder
//
//  Created by Hyeji on 2021/08/03.
//

import Foundation

struct SharePersonal {

    // 2021.08.03 조혜지 Personal Option에서 필요한 변수 추가
    static var coffee: String = ""
    static var vSyrup: String = ""
    static var hSyrup: String = ""
    static var cSyrup: String = ""
    static var ice: String = ""
    static var whip: String = ""
    static var caramelDrizzle: String = ""
    static var chocoDrizzle: String = ""
    static var lid: String = ""
    
    // 2021.08.04 조혜지 Personal Option에서 필요한 변수 추가
    static var coffeeCount: Int = 0
    static var coffeeState: Int = 0
    static var coffeePrice: Int = 0
    static var vSyrupCount: Int = 0
    static var hSyrupCount: Int = 0
    static var cSyrupCount: Int = 0
    static var vSyrupPrice: Int = 0
    static var hSyrupPrice: Int = 0
    static var cSyrupPrice: Int = 0
    static var whipState: Int = 0
    static var whipPrice: Int = 0
    static var caramelDrizzleState: Int = 0
    static var chocoDrizzleState: Int = 0
    static var carameldrizzlePrice: Int = 0
    static var chocolatedrizzlePrice: Int = 0
    
    // 2021.08.06 조혜지 장바구니에 이미 제품이 있는지 여부 알려주는 상태 변수 추가
    static var existCart: Bool = false
    static var existCartId: String = ""
    static var existCartCount: Int = 0
}
