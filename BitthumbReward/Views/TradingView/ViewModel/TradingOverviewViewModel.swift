//
//  TradingOverviewViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

struct TradingOverviewViewModel {
    ///
    let ticker: String
    ///
    let tradePrice: Double
    ///
    let highPrice: Double
    ///
    let lowPrice: Double
    ///
    let changeRate: Double
    
    ///
    var formattedChangeRate: String {
        let formatted = changeRate.formatted(.percent.precision(.fractionLength(2)))
        return (changeRate > 0.0 ? "+" : "-") + formatted
    }
}


extension TradingOverviewViewModel {
    
    static let mock: Self = .init(
        ticker: "BTC-KRW",
        tradePrice: 149322000,
        highPrice: 198323000,
        lowPrice: 73492390,
        changeRate: 0.0012345
    )
}
