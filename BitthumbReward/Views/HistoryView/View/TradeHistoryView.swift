//
//  TradeHistoryView.swift
//  BitthumbReward
//
//  Created by kangho on 11/16/25.
//

import SwiftUI

struct TradeHistoryView: View {
    private let client = BithumbClient(session: .shared)
    
    typealias Coin = String
    let coin: Coin
    
    var body: some View {
        Text("TradeHistoryView")
            
    }
}
