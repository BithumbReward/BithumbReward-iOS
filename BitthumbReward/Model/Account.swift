//
//  Account.swift
//  BitthumbReward
//
//  Created by kangho on 11/13/25.
//

import Foundation

// MARK: - Account
struct Account: Codable {
    let currency: String
    let balance, locked, avgBuyPrice: String
    let avgBuyPriceModified: Bool
    let unitCurrency: String

    enum CodingKeys: String, CodingKey {
        case currency, balance, locked
        case avgBuyPrice = "avg_buy_price"
        case avgBuyPriceModified = "avg_buy_price_modified"
        case unitCurrency = "unit_currency"
    }
}

typealias Accounts = [Account]

extension Account: Identifiable {
    var id: String {
        currency
    }
}
//
//extension Array where Element == Account {
//    static let previews: [Account] = [
//        .init(currency: "BTC", balance: "0.00000000", locked: "0.00000000", avgBuyPrice: "0.00000000", avgBuyPriceModified: false, unitCurrency: "BTC"),
//        .init(currency: "ETH", balance: "0.00000000", locked: "0.00000000", avgBuyPrice: "0.00000000", avgBuyPriceModified: false, unitCurrency: "ETH"),
//        .init(currency: "BNB", balance: "0.00000000", locked: "0.00000000", avgBuyPrice: "0.00000000", avgBuyPriceModified: false, unitCurrency: "BNB"),
//        .init(currency: "USDT", balance: "0.00000000", locked: "0.00000000", avgBuyPrice: "0.00000000", avgBuyPriceModified: false, unitCurrency: "USDT"),
//    ]
//}
