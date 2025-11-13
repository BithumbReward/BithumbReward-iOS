//
//  Order.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

// MARK: - Order
struct Order: Codable {
    let uuid, side, ordType, price: String
    let state, market: String
    let createdAt: Date
    let volume, remainingVolume, reservedFee, remainingFee: String
    let paidFee, locked, executedVolume: String
    let tradesCount: Int

    enum CodingKeys: String, CodingKey {
        case uuid, side
        case ordType = "ord_type"
        case price, state, market
        case createdAt = "created_at"
        case volume
        case remainingVolume = "remaining_volume"
        case reservedFee = "reserved_fee"
        case remainingFee = "remaining_fee"
        case paidFee = "paid_fee"
        case locked
        case executedVolume = "executed_volume"
        case tradesCount = "trades_count"
    }
}
