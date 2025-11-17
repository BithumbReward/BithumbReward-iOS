//
//  TradingViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/13/25.
//

import SwiftUI

@Observable
final class TradingViewModel {
    
    ///
    var overview: TradingOverviewViewModel?
    ///
    var showWarningAlert: Bool = false
    
    ///
    var tradeType: BuyAndSellButton.`Type` = .buy
    ///
    var tradeAmount: String = ""
    ///
    var isShimmering: Bool = false
    
    ///
    var buySellAmount: Int {
        tradeAmount.toInt ?? 0
    }
    ///
    var purchasableCoin: String {
        guard let ov = overview else { return "-" }
        let pcCoin = Double(buySellAmount) / Double(ov.tradePrice)
        return pcCoin.formatted(.number.precision(.fractionLength(1)))
    }
    
    
    private let bithumbClient = BithumbClient(session: .shared)
    
    /// <#Description#>
    /// - Parameter marketCode: <#marketCode description#>
    /// - Returns: <#description#>
    @discardableResult
    func fetchCurrentTradePrice(on marketCode: String) async throws -> Ticker {
        guard let ticker = try await bithumbClient.ticker([marketCode]).first
        else { throw URLError(.badServerResponse) }
        
        let overview = TradingOverviewViewModel(
            ticker: ticker.market,
            tradePrice: ticker.tradePrice,
            highPrice: ticker.highest52WeekPrice,
            lowPrice: ticker.lowest52WeekPrice,
            changeRate: ticker.changeRate
        )
        self.overview = overview
        return ticker
    }
    
    /// <#Description#>
    /// - Parameters:
    ///   - market: <#market description#>
    ///   - side: <#side description#>
    ///   - volume: <#volume description#>
    ///   - price: <#price description#>
    /// - Returns: <#description#>
    func tradeMarket(
        _ market: String,
        side: String,
        volume: Double,
        price: Double
    ) async throws -> Order {
        // 코인 현재가를 불러올 수 없다면 트레이드 취소
        guard let _ = overview else { throw URLError(.cancelled) }
        
        let request = OrderRequest(
            market: market,
            side: side,
            volume: volume,
            price: price,
            orderType: "limit" // 지정가 주문
        )
        return try await bithumbClient.order(request)
    }
    
    private func toggleIsShimmering(to active: Bool? = nil) {
        if let active = active { isShimmering = active }
        else { isShimmering.toggle() }
    }
}


fileprivate extension String {
    var toInt: Int? { Int(self) }
}
