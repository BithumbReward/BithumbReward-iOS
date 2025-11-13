//
//  OrderFetchRequest.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

struct OrderFetchRequest: Encodable {
    let market: String
    let uuids: [String]
    let state: String
    let states: [String]
    let page: Int = 1
    let limit: Int = 100
    let orderBy: String = "desc"
    
    private enum CodingKeys: String, CodingKey {
        case market
        case uuids
        case state
        case states
        case page
        case limit
        case orderBy = "order_by"
    }
}
