//
//  CoinRowViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import Foundation

struct MarketRowViewModel: Identifiable {
    ///
    let ticker: String
    ///
    let fullName: String
    ///
    let tradePrice: Double
    ///
    let highPrice: Double
    ///
    let lowPrice: Double
    ///
    let changeRate: Double
    
    var id: String { ticker }
    
    ///
    var formattedTradePrice: String {
        return tradePrice.formatted(.number.precision(.fractionLength(1)))
    }
    
    ///
    var formattedChangeRate: String {
        let formatted = changeRate.formatted(.percent.precision(.fractionLength(2)))
        return (changeRate > 0.0 ? "+" : "-") + formatted
    }
}

extension MarketRowViewModel: Hashable {
}
