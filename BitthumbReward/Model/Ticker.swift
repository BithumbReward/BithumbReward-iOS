//
//  Ticker.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

// MARK: - Ticker

import Foundation

struct Ticker: Codable {
    let market: String
    let tradeDate: String
    let tradeTime: String
    let tradeDateKst: String
    let tradeTimeKst: String
    let tradeTimestamp: Int
    let openingPrice: Double
    let highPrice: Double
    let lowPrice: Double
    let tradePrice: Double
    let prevClosingPrice: Double
    let change: String
    let changePrice: Double
    let changeRate: Double
    let signedChangePrice: Double
    let signedChangeRate: Double
    let tradeVolume: Double
    let accTradePrice: Double
    let accTradePrice24H: Double
    let accTradeVolume: Double
    let accTradeVolume24H: Double
    let highest52WeekPrice: Double
    let highest52WeekDate: String
    let lowest52WeekPrice: Double
    let lowest52WeekDate: String
    
    let timestamp: Int

    enum CodingKeys: String, CodingKey {
        case market
        case tradeDate = "trade_date"
        case tradeTime = "trade_time"
        case tradeDateKst = "trade_date_kst"
        case tradeTimeKst = "trade_time_kst"
        case tradeTimestamp = "trade_timestamp"
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case change
        case changePrice = "change_price"
        case changeRate = "change_rate"
        case signedChangePrice = "signed_change_price"
        case signedChangeRate = "signed_change_rate"
        case tradeVolume = "trade_volume"
        case accTradePrice = "acc_trade_price"
        case accTradePrice24H = "acc_trade_price_24h"
        case accTradeVolume = "acc_trade_volume"
        case accTradeVolume24H = "acc_trade_volume_24h"
        case highest52WeekPrice = "highest_52_week_price"
        case highest52WeekDate = "highest_52_week_date"
        case lowest52WeekPrice = "lowest_52_week_price"
        case lowest52WeekDate = "lowest_52_week_date"
        case timestamp
    }
}

typealias Tickers = [Ticker]
