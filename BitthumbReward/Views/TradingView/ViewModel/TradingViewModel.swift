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
    var tradeAmount: String = ""
    
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
    
    /*
    func fetchMarketPrice() async throws -> MarketInfoResponse {
        
    }
    
    func tradeMarket(
        _ coin: String,
        side: TradeSide,
        volume: Int,
        price: Int
    ) async throws -> Bool {
     
    }
     
     private func removeMarketPrice() {
     
     }
     */
}


fileprivate extension String {
    var toInt: Int? { Int(self) }
}
