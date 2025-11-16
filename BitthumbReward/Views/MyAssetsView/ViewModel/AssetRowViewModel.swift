//
//  AssetRowViewModel.swift
//  BitthumbReward
//
//  Created by kangho on 11/16/25.
//

import Foundation

struct AssetRowViewModel: Identifiable {
    private let account: Account
    private let ticker: Ticker
    
    var id: String {
        account.currency
    }
    
    init(account: Account, ticker: Ticker) {
        self.account = account
        self.ticker = ticker
    }
    
    let currentPrice: Double = 1000
    
    var currency: String = "BTC"
    
    var balance: Double = 0
    
    /// 원화 환산 금액 - balance - current price
    var balanceKRW: Double {
//        currentPrice * (Double(account.balance) ?? 0)
        57698
    }
    
    /// 등락폭 - current ticker / ave buy Price
    var changeRate: Double {
        return 0
    }
    
    /// 등락금액 - 등락폭 * balance
    var changePrice: Double {
        (Double(account.balance) ?? 0) * changeRate
    }
    
    var changeValue: String {
        "+11,436(24.7%)"
    }
}
