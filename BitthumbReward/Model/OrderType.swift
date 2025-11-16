//
//  OrderType.swift
//  BitthumbReward
//
//  Created by kangho on 11/16/25.
//

import Foundation

enum Side: String, Codable {
    case bid = "bid"
    case ask = "ask"
    
    var title: String {
        switch self {
        case .bid:
            "매수"
        case .ask:
            "매도"
        }
    }
}

enum OrderType: String, Codable {
    case price
    case limit
    case market
    
    var title: String {
        switch self {
        case .price:
            "시장가 주문(매수)"
        case .limit:
            "지정가 주문"
        case .market:
            "시장가 주문(매도)"
        }
    }
}

enum OrderState: String, Codable {
    case wait
    case cancel
    case done
    case watch
    
    var title: String {
        switch self {
        case .wait:
            "체결 대기"
        case .cancel:
            "주문 취소"
        case .done:
            "전체 체결 완료"
        case .watch:
            "예약주문 대기"
        }
    }
}
