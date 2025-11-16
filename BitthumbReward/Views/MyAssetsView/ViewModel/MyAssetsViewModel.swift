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
    var totalBalance: Double = 0
    
    var totalBalanceString: String {
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.locale = Locale(identifier: "ko-kr")
        
        return (formater.string(from: NSNumber(value: totalBalance)) ?? "-")
    }
    
    var koreanBalance: String {
        let formater = NumberFormatter()
        formater.numberStyle = .currency
        formater.locale = Locale(identifier: "ko-kr")
        
        return (formater.string(from: NSNumber(value: balance)) ?? "-") + " 원"
    }
    
    func fetch() async {
        do {
            let accounts = try await client.account()
            let markets = accounts
                .filter { $0.currency != "KRW" }
                .map { "KRW-\($0.currency)" }
            
            let tickers = try await client.ticker(markets.isEmpty ? ["KRW-BTC"] : markets)
            
            balance = Double((accounts.first(where: { $0.currency == "KRW" })?.balance ?? "0")) ?? 0
            
            let zipped = accounts
                .filter { $0.currency != "KRW" }
                .compactMap { account in
                    if let ticker = tickers.first(where: { $0.market.split(separator: "-")[1] == account.currency }) {
                        return (account, ticker)
                    } else {
                        return nil
                    }
                }
                .reduce(into: [String: (Account, Ticker)]()) { $0[$1.0.currency] = $1 }
            
            totalBalance = zipped
                .mapValues({ a, t in
                    (Double(a.balance) ?? 0) * t.tradePrice
                })
                .values
                .reduce(0, +)
            
            totalBalance += balance
            
            assetRows = zipped.values
                .map { account, ticker in
                    AssetRowViewModel(account: account, ticker: ticker)
                }
            
            if assetRows.isEmpty {
                assetRows = [ .preview ]
            }
            
        } catch {
            print(error)
        }
    }
}

