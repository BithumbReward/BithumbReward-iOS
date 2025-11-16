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
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.market, forKey: .market)
        try container.encode(self.side, forKey: .side)
        if volume != 0 {
            try container.encode(self.volume, forKey: .volume)
        }
        try container.encode(self.price, forKey: .price)
        try container.encode(self.orderType, forKey: .orderType)
    }
}
