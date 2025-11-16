//
//  MyAssetsViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

@Observable
final class MyAssetsViewModel {
    private let client: BithumbClient
    var assetRows: [AssetRowViewModel] = []
    
    init(client: BithumbClient = BithumbClient(session: .shared)) {
        self.client = client
    }
    
    var balance: Double = 0
    
    func fetch() async {
        do {
            let accounts = try await client.account()
            let markets = accounts
                .filter { $0.currency != "KRW" }
                .map { "KRW-\($0.currency)" }
            
            let tickers = try await client.ticker(markets.isEmpty ? ["KRW-BTC"] : markets)
            
            balance = Double((accounts.first(where: { $0.currency == "KRW" })?.balance ?? "0")) ?? 0
            
            assetRows = accounts
                .filter { $0.currency != "KRW" }
                .compactMap { account in
                    if let ticker = tickers.first(where: { $0.market.split(separator: "-")[1] == account.currency }) {
                        return (account, ticker)
                    } else {
                        return nil
                    }
                }
                .reduce(into: [String: (Account, Ticker)]()) { $0[$1.0.currency] = $1 }.values
                .map { account, ticker in
                    AssetRowViewModel(account: account, ticker: ticker)
                }
            
            if assetRows.isEmpty {
                assetRows = [
                    .init(
                        account: .init(
                            currency: "BTC",
                            balance: "124.45272908",
                            locked: "0",
                            avgBuyPrice: "36340973",
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
                            tradePrice: 0,
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
                ]
            }
            
        } catch {
            print(error)
        }
    }
}
