//
//  CoinRowViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import Foundation

struct CoinRowViewModel: Identifiable {
    ///
    let ticker: String
    ///
    let fullName: String
    ///
    let tradePrice: Int
    ///
    let changeRate: Double
    
    var id: String { ticker }
    
    ///
    var formattedChangeRate: String {
        let formatted = changeRate.formatted(.percent.precision(.fractionLength(2)))
        return (changeRate > 0.0 ? "+" : "-") + formatted
    }
}

extension CoinRowViewModel: Hashable {
}
