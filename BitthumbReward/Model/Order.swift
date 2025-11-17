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

extension Order {
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.uuid = try container.decode(String.self, forKey: .uuid)
        self.side = try container.decode(String.self, forKey: .side)
        self.ordType = try container.decode(String.self, forKey: .ordType)
        self.price = try container.decode(String.self, forKey: .price)
        self.state = try container.decode(String.self, forKey: .state)
        self.market = try container.decode(String.self, forKey: .market)
        self.createdAt = try container.decode(Date.self, forKey: .createdAt)
        self.volume = try container.decodeIfPresent(String.self, forKey: .volume) ?? "-"
        self.remainingVolume = try container.decodeIfPresent(String.self, forKey: .remainingVolume) ?? "-"
        self.reservedFee = try container.decode(String.self, forKey: .reservedFee)
        self.remainingFee = try container.decode(String.self, forKey: .remainingFee)
        self.paidFee = try container.decode(String.self, forKey: .paidFee)
        self.locked = try container.decode(String.self, forKey: .locked)
        self.executedVolume = try container.decode(String.self, forKey: .executedVolume)
        self.tradesCount = try container.decode(Int.self, forKey: .tradesCount)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.uuid, forKey: .uuid)
        try container.encode(self.side, forKey: .side)
        try container.encode(self.ordType, forKey: .ordType)
        try container.encode(self.price, forKey: .price)
        try container.encode(self.state, forKey: .state)
        try container.encode(self.market, forKey: .market)
        try container.encode(self.createdAt, forKey: .createdAt)
        try container.encodeIfPresent(self.volume, forKey: .volume)
        try container.encodeIfPresent(self.remainingVolume, forKey: .remainingVolume)
        try container.encode(self.reservedFee, forKey: .reservedFee)
        try container.encode(self.remainingFee, forKey: .remainingFee)
        try container.encode(self.paidFee, forKey: .paidFee)
        try container.encode(self.locked, forKey: .locked)
        try container.encode(self.executedVolume, forKey: .executedVolume)
        try container.encode(self.tradesCount, forKey: .tradesCount)
    }
}

extension Order {
    static let preview: Order = .init()
    
    private init() {
        self.uuid = "C0101000000001799653"
        self.side = "bid"
        self.ordType = "limit"
        self.price = "84000000"
        self.state = "wait"
        self.market = "KRW-BTC"
        self.createdAt = Date()
        self.volume = "0.0001"
        self.remainingVolume = "0.0001"
        self.reservedFee = "21"
        self.remainingFee = "21"
        self.paidFee = "0"
        self.locked = "8422"
        self.executedVolume = "0"
        self.tradesCount = 0
    }
}

extension Order: Identifiable {
    var id: String {
        uuid
    }
}
