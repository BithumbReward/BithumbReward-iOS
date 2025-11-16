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
        market
    }
    
    var market: String {
        ticker.market
    }
    
    init(account: Account, ticker: Ticker) {
        self.account = account
        self.ticker = ticker
    }
    
    var name: String {
        ticker.market
    }
    
    var currency: String {
        account.currency
    }
    
    var balance: String {
        account.balance + " " + account.currency
    }
    
    /// 원화 환산 금액 - balance - current price
    var balanceKRW: Double {
        ticker.tradePrice * (Double(account.balance) ?? 0)
    }
    
    /// 등락폭 - current ticker / ave buy Price
    var changeRate: Double {
        let balance = Double(account.balance) ?? 0
        let prev = Double(account.avgBuyPrice) ?? 0
        
        let buyAmount = prev * balance
        
        return changePrice / buyAmount
    }
    
    /// 등락금액 - 등락폭 * balance
    var changePrice: Double {
        let balance = Double(account.balance) ?? 0
        let prev = Double(account.avgBuyPrice) ?? 0
        let current = ticker.tradePrice
        
        return (current - prev) * balance
    }
    
    var changeValue: String {
        let formattedRate = abs(changeRate).formatted(.percent.precision(.fractionLength(2)))
        let formattedPrice = changePrice.formatted(.number.precision(.fractionLength(2)))
        return (changeRate > 0.0 ? "+" : "") + formattedPrice + " (\(formattedRate))"
    }
}

/// 143 824 000 . 0.97 /  -7 /  -0.14

extension AssetRowViewModel {
    static let preview: AssetRowViewModel = .init(
        account: .init(
            currency: "BTC",
            balance: "0.00003472",
            locked: "0",
            avgBuyPrice: "143997000",
            avgBuyPriceModified: false,
            unitCurrency: "KRW"
        ),
        ticker: .init(
            market: "KRW-BTC",
            tradeDate: Date().description,
            tradeTime: "",
            tradeDateKst: "",
            tradeTimeKst: "",
            tradeTimestamp: 0,
            openingPrice: 0,
            highPrice: 0,
            lowPrice: 0,
            tradePrice: 143824000,
            prevClosingPrice: 0,
            change: "",
            changePrice: 0,
            changeRate: 0,
            signedChangePrice: 0,
            signedChangeRate: 0,
            tradeVolume: 0,
            accTradePrice: 0,
            accTradePrice24H: 0,
            accTradeVolume: 0,
            accTradeVolume24H: 0,
            highest52WeekPrice: 0,
            highest52WeekDate: "",
            lowest52WeekPrice: 0,
            lowest52WeekDate: "",
            timestamp: 0
        )
    )
}
