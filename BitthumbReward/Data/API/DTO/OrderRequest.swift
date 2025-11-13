//
//  OrderRequest.swift
//  BitthumbReward
//
//  Created by kangho on 11/12/25.
//

import Foundation

struct OrderRequest: Encodable {
    let market: String
    let side: String
    let volume: Double
    let price: Double
    let orderType: String
    
    private enum CodingKeys: String, CodingKey {
        case market = "market"
        case side = "side"
        case volume = "volume"
        case price = "price"
        case orderType = "ord_type"
    }
}
