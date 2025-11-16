//
//  MarketListViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

@Observable
final class MarketListViewModel {
    
    var listOfMarkets: [MarketRowViewModel] = []
    
    var showWarningAlert = false
    var showLoadingIndicator = true
    
    private let bithumbClient = BithumbClient(session: .shared)
    
    init(listOfMarkets: [MarketRowViewModel] = []) {
        self.listOfMarkets = listOfMarkets
    }
    
    
    /// <#Description#>
    /// - Parameter isDetails: <#isDetails description#>
    func fetchAvailableMarkets() async throws {
        let markets = try await bithumbClient.markets()
        let filteredMarkets = markets.filter { $0.market.hasPrefix("KRW-") }.map { $0.market }
        self.listOfMarkets = try await fetchCurrentTradePrice(on: filteredMarkets)
            .map { coin in
                guard let market = markets.first(where: { $0.market == coin.market})
                else { throw URLError(.unknown) }
                
                return MarketRowViewModel(
                    ticker: coin.market,
                    fullName: market.englishName,
                    tradePrice: coin.tradePrice,
                    highPrice: coin.highest52WeekPrice,
                    lowPrice: coin.lowest52WeekPrice,
                    changeRate: coin.changeRate
                )
            }
            .sorted {
                $0.fullName < $1.fullName
            }
        }
    
    
    /// <#Description#>
    /// - Parameter marketCode: <#marketCode description#>
    /// - Returns: <#description#>
    private func fetchCurrentTradePrice(on marketCodes: [String]) async throws -> [Ticker] {
        try await bithumbClient.ticker(marketCodes)
    }
}


fileprivate extension Array {
    
    func concurrentMap<T>(_ transform: @escaping (Element) async throws -> T) async rethrows -> [T] where Element: Sendable {
        var array: [T] = []
        await withThrowingTaskGroup { group in
            for element in self {
                group.addTask {
                    try await transform(element)
                }
            }
            
            do {
                for try await g in group {
                    array.append(g)
                }
            } catch { }
        }
        return array
    }
}
