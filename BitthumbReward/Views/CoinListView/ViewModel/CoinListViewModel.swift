//
//  CoinListViewModel.swift
//  BitthumbReward
//
//  Created by 김건우 on 11/14/25.
//

import SwiftUI

@Observable
final class CoinListViewModel {
    
    var listOfCoins: [CoinRowViewModel] = []
    var showLoadingIndicator = true
    
    init(listOfCoins: [CoinRowViewModel] = []) {
        self.listOfCoins = listOfCoins
    }
    
    /*
    func fetchAvailableCoins(isDetails: Bool = false) async throws -> [CoinMarketResponse] {
    }
    
    func fetchCurrentTradePrice(on marketCode: String) async throws -> [CoinTicksResponse] {
    }
    */
}
